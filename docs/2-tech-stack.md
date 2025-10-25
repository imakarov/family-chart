# Technology Stack — Family Chart

## Выбранные технологии

### ✅ State Management: **Riverpod**

**Версия:** `flutter_riverpod: ^2.5.1`

**Почему выбрали:**
- ✅ Современный и рекомендованный Flutter team
- ✅ Type-safe с compile-time safety
- ✅ Минимальный boilerplate код
- ✅ Встроенный Dependency Injection
- ✅ Отличная документация

**Как используется:**

```dart
// 1. Provider для данных
@riverpod
Future<List<Checklist>> checklists(ChecklistsRef ref) async {
  final repository = ref.read(checklistRepositoryProvider);
  return await repository.getAllChecklists();
}

// 2. Consumer Widget
class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checklistsAsync = ref.watch(checklistsProvider);

    return checklistsAsync.when(
      data: (checklists) => ChecklistsList(checklists),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(err),
    );
  }
}
```

**Документация:** https://riverpod.dev

---

### ✅ Local Database: **Isar**

**Версия:** `isar: ^3.1.0+1`

**Почему выбрали:**
- ✅ Очень быстрая (быстрее Hive и SQLite)
- ✅ NoSQL с гибкими схемами
- ✅ Отличная поддержка relationships
- ✅ Reactive queries (Stream)
- ✅ Null-safety из коробки
- ✅ Встроенный инспектор для отладки

**Как используется:**

```dart
// 1. Определение модели
@collection
class Checklist {
  Id id = Isar.autoIncrement;

  late String name;
  late DateTime startDate;

  // Relationships
  final persons = IsarLinks<Person>();
  final tasks = IsarLinks<Task>();
}

// 2. Запросы
final checklists = await isar.checklists.where().findAll();

// 3. Фильтрация
final active = await isar.checklists
  .filter()
  .endDateGreaterThan(DateTime.now())
  .findAll();

// 4. Reactive (Stream)
final stream = isar.checklists.where().watch(fireImmediately: true);
```

**Документация:** https://isar.dev

---

### ✅ Routing: **go_router**

**Версия:** `go_router: ^13.2.0`

**Почему выбрали:**
- ✅ Официальный от Flutter team
- ✅ Declarative routing
- ✅ Deep linking из коробки
- ✅ Type-safe routes
- ✅ Отлично работает с web

**Как используется:**

```dart
// 1. Определение routes
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => DashboardScreen(),
    ),
    GoRoute(
      path: '/checklist/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return WeeklyBoardScreen(checklistId: id);
      },
    ),
  ],
);

// 2. Навигация
context.go('/checklist/123');
context.push('/onboarding');
```

**Документация:** https://pub.dev/packages/go_router

---

### ✅ Dependency Injection: **Riverpod Providers**

**Встроено в Riverpod** — отдельный DI не нужен!

```dart
// Providers автоматически работают как DI
@riverpod
ChecklistRepository checklistRepository(ChecklistRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return ChecklistRepository(isar);
}

// Использование
final repository = ref.read(checklistRepositoryProvider);
```

---

### ✅ UI: **Material 3 + Custom Design System**

**Liquid Design на основе HTML прототипов**

**Что реализуем:**
- ✅ Прозрачные карточки с размытием (Liquid Cards)
- ✅ Мягкие тени и скругления
- ✅ Dynamic Island support (iPhone 16 Pro)
- ✅ Chevron компоненты
- ✅ Цветные аватары участников
- ✅ Иконки задач

**Theme:**
```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF007AFF), // iOS Blue
    brightness: Brightness.light,
  ),
  // Custom liquid design settings
)
```

---

## Дополнительные библиотеки

### Firebase
- `firebase_core: ^2.27.0` — Базовая инициализация
- `firebase_remote_config: ^4.3.17` — Feature flags, pricing
- `firebase_analytics: ^10.8.9` — Аналитика событий

### Analytics
- `amplitude_flutter: ^3.16.2` — Amplitude Analytics

### Contacts Integration
- `flutter_contacts: ^1.1.7` — Доступ к контактам
- `permission_handler: ^11.2.0` — Запрос разрешений

### Localization
- `easy_localization: ^3.0.5` — Мультиязычность (RU/EN)

### Utilities
- `uuid: ^4.3.3` — Генерация UUID для моделей
- `intl: ^0.19.0` — Форматирование дат
- `path_provider: ^2.1.2` — Пути к директориям

---

## Архитектура папок

```
lib/
├── core/                      # Общие компоненты
│   ├── constants/            # Константы приложения
│   │   └── app_constants.dart
│   ├── providers/            # Глобальные providers
│   │   ├── isar_provider.dart
│   │   └── router_provider.dart
│   ├── theme/                # Тема и дизайн
│   └── utils/                # Утилиты
│
├── data/                      # Слой данных
│   ├── models/               # Isar модели
│   │   └── checklist.dart    # Checklist, Person, Task, TaskCompletion
│   ├── repositories/         # Репозитории для работы с БД
│   │   └── checklist_repository.dart
│   └── datasources/          # Источники данных (CloudKit, Firebase)
│
├── features/                  # Функциональные модули
│   ├── onboarding/           # Онбординг
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   ├── dashboard/            # Главный экран
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   ├── weekly_board/         # Weekly Board
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   └── settings/             # Настройки
│       ├── screens/
│       ├── widgets/
│       └── providers/
│
└── main.dart                  # Entry point
```

---

## Code Generation

**Используемые генераторы:**

```yaml
dev_dependencies:
  build_runner: ^2.4.8
  riverpod_generator: ^2.3.11    # Для @riverpod аннотаций
  isar_generator: ^3.1.0+1        # Для @collection моделей
  go_router_builder: ^2.4.1       # Для type-safe routes
```

**Команды:**

```bash
# Запустить code generation
flutter pub run build_runner build

# Watch mode (автоматическая генерация при изменениях)
flutter pub run build_runner watch

# Очистить и пересоздать
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Setup Instructions

### 1. Установка зависимостей

```bash
cd app
flutter pub get
```

### 2. Запуск code generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Запуск приложения

```bash
flutter run
```

---

## Следующие шаги

1. ✅ Зависимости установлены
2. ✅ Базовая структура папок создана
3. ✅ Примеры кода добавлены
4. ⏭️ Запустить code generation
5. ⏭️ Начать реализацию MVP (Фаза 3)

---

## Полезные ссылки

- [Riverpod Documentation](https://riverpod.dev)
- [Isar Database](https://isar.dev)
- [go_router](https://pub.dev/packages/go_router)
- [Flutter Contacts](https://pub.dev/packages/flutter_contacts)
- [Firebase Flutter](https://firebase.flutter.dev)
