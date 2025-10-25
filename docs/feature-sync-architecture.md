# CloudKit Sync Architecture — Family Chart

## Обзор

Family Chart использует **Local-first архитектуру** с **опциональной синхронизацией через CloudKit**.

### Ключевые принципы:

1. **Локальная БД = источник истины** — все данные хранятся локально (Hive/Isar)
2. **Приложение работает БЕЗ интернета** — полная функциональность offline
3. **CloudKit = опциональный sync layer** — включается по запросу пользователя
4. **Не требуется авторизация** — CloudKit использует iCloud аккаунт устройства
5. **Бесплатно** — для разработчика и пользователя

---

## Архитектура

```
┌─────────────────────────────────────────────────┐
│                   UI Layer                      │
│  (Weekly Board, Dashboard, Settings)            │
└───────────────────┬─────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────┐
│              Repository Pattern                 │
│  • Всегда читает из Local DB                    │
│  • Всегда пишет в Local DB                      │
│  • Триггерит CloudKitSync (если включен)        │
└───────────────────┬─────────────────────────────┘
                    │
      ┌─────────────┴─────────────┐
      │                           │
┌─────▼──────────┐    ┌───────────▼──────────┐
│   Local DB     │    │   CloudKit Sync      │
│   (Hive/Isar)  │    │   (опционально)      │
│                │    │                      │
│  • Offline ✅  │    │  • Если iCloud ✅    │
│  • Всегда      │    │  • Фоновый процесс   │
│    работает    │    │  • Не блокирует UI   │
└────────────────┘    └──────────────────────┘
                               │
                    ┌──────────▼──────────┐
                    │   iCloud (CloudKit) │
                    │  • Private Database │
                    │  • Shared Database  │
                    └─────────────────────┘
```

---

## CloudKit Schema

### Record Types

#### 1. Checklist
```swift
RecordType: "Checklist"
Fields:
  - id: String (UUID)
  - name: String
  - startDate: Date
  - endDate: Date
  - isRepeating: Bool
  - createdBy: String (user identifier)
  - createdAt: Date
  - modifiedAt: Date
```

#### 2. Person
```swift
RecordType: "Person"
Fields:
  - id: String (UUID)
  - name: String
  - avatar: Asset (CKAsset - фото)
  - color: String (hex)
  - checklistId: Reference(Checklist)
  - createdAt: Date
  - modifiedAt: Date
```

#### 3. Task
```swift
RecordType: "Task"
Fields:
  - id: String (UUID)
  - title: String
  - icon: String (icon identifier)
  - frequency: String (daily/weekly/custom)
  - frequencyData: String (JSON для custom frequency)
  - assignedTo: Reference(Person)
  - checklistId: Reference(Checklist)
  - createdAt: Date
  - modifiedAt: Date
```

#### 4. TaskCompletion
```swift
RecordType: "TaskCompletion"
Fields:
  - id: String (UUID)
  - taskId: Reference(Task)
  - personId: Reference(Person)
  - checklistId: Reference(Checklist)
  - date: Date (день выполнения)
  - isCompleted: Bool
  - completedAt: Date (timestamp)
  - completedBy: String (deviceId)
  - modifiedAt: Date
```

**Почему гранулярные записи:**
- Нет конфликтов между разными задачами
- Каждая отметка = независимая запись
- Append-only для TaskCompletion

---

## Синхронизация: Когда включается?

### Триггеры для предложения CloudKit:

#### 1. Установка на второе устройство
```
Пользователь открывает приложение на iPad:
┌──────────────────────────────────────┐
│ 📱 Синхронизация устройств           │
│                                      │
│ Используйте iCloud для доступа к     │
│ чеклистам на всех устройствах        │
│                                      │
│ [Включить синхронизацию]             │
│                                      │
│ или                                  │
│                                      │
│ [Начать заново на этом устройстве]   │
└──────────────────────────────────────┘
```

#### 2. Нажатие "Поделиться чеклистом"
```
if (iCloudAvailable) {
  createShare() → показать Share Sheet
} else {
  показать попап:
  "Для совместного доступа требуется iCloud"
  [Открыть Настройки] [Отмена]
}
```

#### 3. Settings → Синхронизация
```
Settings screen:
┌──────────────────────────────────────┐
│ iCloud Синхронизация         [ON]   │
│                                      │
│ Все чеклисты синхронизируются через │
│ ваш iCloud аккаунт                   │
│                                      │
│ Последняя синхронизация: 2 мин назад │
│                                      │
│ Устройства:                          │
│ • iPhone 15 Pro (это устройство)    │
│ • iPad Air                          │
└──────────────────────────────────────┘
```

#### 4. Деликатный banner (после 3+ дней)
```
Dashboard, внизу экрана:
┌──────────────────────────────────────┐
│ 💡 Используйте на iPad?              │
│    Включите синхронизацию            │  [×]
└──────────────────────────────────────┘
```

---

## Стоимость

### Для разработчика:
**✅ БЕСПЛАТНО** (до лимитов)
- 1 PB публичной БД
- 10 TB приватной БД на пользователя
- 2 GB asset storage на пользователя
- Неограниченные requests для authenticated users

### Для пользователя:
**✅ БЕСПЛАТНО**
- Использует существующий iCloud аккаунт
- Не требуется iCloud+ подписка

---

## Conflict Resolution

### Стратегия: Приоритет completed задачам

```dart
ConflictResolver {
  // Правило 1: Completed выигрывает над uncompleted
  if (localRecord.isCompleted && !serverRecord.isCompleted) {
    return localRecord;  // ✓ выигрывает
  }
  if (!localRecord.isCompleted && serverRecord.isCompleted) {
    return serverRecord;  // ✓ выигрывает
  }

  // Правило 2: Если обе ✓ или обе ✗ — последняя правка
  if (localRecord.modifiedAt > serverRecord.modifiedAt) {
    return localRecord;
  } else {
    return serverRecord;
  }
}
```

---

## Миграция: Local → Cloud

### Сценарий: Пользователь включил синхронизацию

```dart
Future<void> migrateLocalToCloud() async {
  // 1. Получаем все локальные данные
  final localChecklists = await localDB.getAllChecklists();
  final localTasks = await localDB.getAllTasks();
  final localCompletions = await localDB.getAllCompletions();

  // 2. Проверяем: есть ли данные в CloudKit?
  final cloudChecklists = await cloudKit.fetchAll();

  if (cloudChecklists.isEmpty) {
    // Новый пользователь iCloud → просто загружаем локальные
    await cloudKit.uploadAll({
      'checklists': localChecklists,
      'tasks': localTasks,
      'completions': localCompletions,
    });
  } else {
    // Уже есть данные в iCloud (с другого устройства)
    // Мержим intelligent merge
    final merged = mergeRecords(
      local: localChecklists,
      cloud: cloudChecklists,
    );

    // Сохраняем в Local DB
    await localDB.replaceAll(merged);

    // Отправляем уникальные локальные в CloudKit
    final uniqueLocal = findUniqueLocal(localChecklists, cloudChecklists);
    await cloudKit.uploadAll(uniqueLocal);
  }
}
```

---

## Скорость синхронизации

| Действие | Время |
|----------|-------|
| Отметить задачу | 1-3 сек |
| Создать чеклист | 2-5 сек |
| Загрузка при запуске | 1-10 сек |
| Фоновая синхронизация | Каждые 30-60 сек |

---

## CloudKit Sharing

### Sharing чеклистов между членами семьи

```dart
// Создать share
Future<String> shareChecklist(Checklist checklist) async {
  // 1. Создать CKShare
  final share = await cloudKit.createShare(checklist.ckRecord);

  // 2. Настроить разрешения
  share.publicPermission = .none;  // Только по ссылке

  // 3. Сохранить
  await cloudKit.save([checklist.ckRecord, share]);

  // 4. Получить URL
  return share.url;
}

// Показать Share Sheet
Future<void> showShareSheet(String shareUrl) async {
  await Share.share(
    shareUrl,
    subject: 'Приглашение в Family Checklist',
  );

  // iOS автоматически предложит:
  // • iMessage
  // • Email
  // • WhatsApp
  // • Telegram
}

// Принять приглашение (автоматически через iOS)
Future<void> acceptShare(CKShareMetadata metadata) async {
  await cloudKit.acceptShare(metadata);
  // Чеклист автоматически появится в Shared Database
}
```

---

## UI: Индикаторы синхронизации

### Dashboard (правый верхний угол)

```dart
Widget buildSyncIndicator(SyncStatus status) {
  switch (status) {
    case SyncStatus.enabled:
      return Icon(Icons.cloud_done, color: Colors.green, size: 20);

    case SyncStatus.syncing:
      return Icon(Icons.cloud_sync, color: Colors.blue);

    case SyncStatus.error:
      return IconButton(
        icon: Icon(Icons.cloud_off, color: Colors.orange),
        onTap: () => showSyncErrorDialog(),
      );

    case SyncStatus.disabled:
      return SizedBox.shrink();  // Не показываем
  }
}
```

---

## Offline-First Flow

```
Пользователь без интернета:
1. Открывает приложение → читает из Local DB ✅
2. Отмечает задачу → пишет в Local DB ✅
3. Sync Service добавляет в очередь: "task1: ✓"
4. UI показывает: "⏱ Синхронизация..."

Появился интернет:
5. Sync Service просыпается
6. Отправляет изменения в CloudKit
7. Получает изменения с других устройств
8. Обновляет Local DB
9. UI обновляется автоматически
10. Иконка: "⏱" → "✓ Синхронизировано"
```

---

## Преимущества CloudKit для Family Chart

✅ **Бесплатно** для разработчика и пользователей
✅ **Автоматическая синхронизация** между устройствами
✅ **Offline-first** из коробки
✅ **Встроенный Sharing** для приглашений
✅ **Conflict resolution** встроенный
✅ **Privacy** — 100% Apple, GDPR compliant
✅ **Только iOS/iPad** — идеально для вашего таргета

---

## Альтернатива: Supabase

❌ **НЕ НУЖЕН** для Family Chart, потому что:

- Нет серверной логики
- Нет кросс-платформы (только iOS/iPad)
- CloudKit покрывает все требования
- Supabase = дополнительные затраты (~$25/мес)
- Supabase = дополнительная точка отказа

**Вывод:** CloudKit — оптимальное решение для Family Chart.

---

## Implementation Roadmap

### Phase 2.3: CloudKit Setup
- [ ] Проектирование CloudKit schema
- [ ] Local-first архитектура
- [ ] Опциональный CloudKit sync layer
- [ ] Conflict resolution
- [ ] Migration: Local → Cloud

### Phase 4.4: CloudKit Sync Implementation
- [ ] Реализация CloudKit sync layer
- [ ] UI для включения/выключения синхронизации
- [ ] Миграция данных
- [ ] Индикаторы статуса синхронизации
- [ ] Тестирование между устройствами

---

## Дополнительные ресурсы

- [Apple CloudKit Documentation](https://developer.apple.com/documentation/cloudkit)
- [CloudKit Best Practices](https://developer.apple.com/videos/play/wwdc2021/10015/)
- [CloudKit Sharing](https://developer.apple.com/documentation/cloudkit/shared_records)
