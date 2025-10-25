# Family Sharing & Contacts Integration — Family Chart

## Обзор

Family Chart использует **Apple Contacts Framework** для умных предложений членов семьи на этапе onboarding.

### Ключевая идея:

Вместо ручного ввода всех членов семьи, приложение:
1. Запрашивает доступ к Contacts (опционально)
2. Находит контакты с семейными отношениями (дочь, сын, жена, муж)
3. Предлагает автоматически добавить их в чеклист
4. Пользователь подтверждает одним тапом

**Результат:** Onboarding за 30 секунд вместо 3-5 минут!

---

## Apple Contacts API

### Доступные данные из Contacts:

```swift
import Contacts

CNContact {
  - givenName: String           // Имя
  - familyName: String          // Фамилия
  - imageData: Data?            // Фото
  - contactRelations: [CNLabeledValue<CNContactRelation>]
  // Отношения: child, daughter, son, parent, mother,
  //            father, spouse, partner, sibling
}
```

---

## Архитектура интеграции

```
┌─────────────────────────────────────────────────┐
│          Onboarding Flow                        │
├─────────────────────────────────────────────────┤
│                                                 │
│  1. Welcome Screen                              │
│     ↓                                           │
│  2. Запрос Contacts permission (опционально)    │
│     ↓                                           │
│  3. Поиск семейных контактов                    │
│     ↓                                           │
│  4. Экран "Добавьте членов семьи"               │
│     ├─ Предлагаемые из Contacts                 │
│     └─ Ручное добавление                        │
│     ↓                                           │
│  5. Выбор задач из библиотеки                   │
│     ↓                                           │
│  6. Назначение задач участникам                 │
│     ↓                                           │
│  7. Готово! → Weekly Board                      │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## Implementation: ContactsService

### Flutter Package
```yaml
dependencies:
  flutter_contacts: ^1.1.7
```

### Dart Implementation

```dart
// lib/services/contacts_service.dart

import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsService {
  // Получить предлагаемых членов семьи из Contacts
  Future<List<SuggestedFamilyMember>> getSuggestedFamilyMembers() async {
    // 1. Запрос разрешения
    if (!await FlutterContacts.requestPermission()) {
      return [];
    }

    // 2. Получить все контакты с фотографиями
    final contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
    );

    List<SuggestedFamilyMember> suggested = [];

    // 3. Фильтрация по семейным отношениям
    for (var contact in contacts) {
      final familyRelations = [
        'child', 'daughter', 'son',        // EN
        'ребенок', 'дочь', 'сын',          // RU
        'parent', 'mother', 'father',
        'родитель', 'мама', 'папа',
        'spouse', 'partner',
        'супруг', 'супруга', 'партнер',
        'sibling', 'brother', 'sister',
        'брат', 'сестра',
      ];

      bool isFamilyMember = false;
      String? relation;

      // Проверка в displayName (например: "Анна (дочь)")
      if (contact.displayName.contains('(')) {
        final match = RegExp(r'\((.*?)\)').firstMatch(contact.displayName);
        if (match != null) {
          relation = match.group(1);
          if (familyRelations.any((r) => relation!.toLowerCase().contains(r))) {
            isFamilyMember = true;
          }
        }
      }

      if (isFamilyMember) {
        suggested.add(SuggestedFamilyMember(
          name: contact.displayName.split('(')[0].trim(),
          relation: relation,
          photo: contact.photo,
          contactId: contact.id,
        ));
      }
    }

    return suggested;
  }
}

class SuggestedFamilyMember {
  final String name;
  final String? relation;
  final Uint8List? photo;
  final String contactId;

  SuggestedFamilyMember({
    required this.name,
    this.relation,
    this.photo,
    required this.contactId,
  });
}
```

---

## UI: Onboarding Screen

### Экран "Добавьте членов семьи"

```dart
// lib/features/onboarding/screens/family_members_screen.dart

class FamilyMembersScreen extends StatefulWidget {
  @override
  _FamilyMembersScreenState createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  List<SuggestedFamilyMember> suggestedMembers = [];
  List<FamilyMember> addedMembers = [];

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final suggestions = await ContactsService().getSuggestedFamilyMembers();
    setState(() {
      suggestedMembers = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Состав семьи'),
      ),
      body: Column(
        children: [
          // Заголовок
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Добавьте членов семьи',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Выберите из ваших контактов или добавьте вручную',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Предлагаемые контакты
          if (suggestedMembers.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Предлагаемые:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: suggestedMembers.length,
              itemBuilder: (context, index) {
                final suggestion = suggestedMembers[index];
                return _buildSuggestedMemberTile(suggestion);
              },
            ),

            Divider(height: 32, thickness: 1),
          ],

          // Уже добавленные
          if (addedMembers.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Добавлено в чеклист:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: addedMembers.length,
                itemBuilder: (context, index) {
                  final member = addedMembers[index];
                  return _buildAddedMemberCard(member);
                },
              ),
            ),
          ],

          // Кнопка "Добавить вручную"
          Padding(
            padding: EdgeInsets.all(16),
            child: OutlinedButton.icon(
              icon: Icon(Icons.person_add),
              label: Text('Добавить члена семьи'),
              onPressed: _addManualMember,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),

          // Кнопка продолжить
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              child: Text('Продолжить'),
              onPressed: addedMembers.isEmpty ? null : _continue,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSuggestedMemberTile(SuggestedFamilyMember suggestion) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: suggestion.photo != null
            ? MemoryImage(suggestion.photo!)
            : null,
        child: suggestion.photo == null
            ? Text(
                suggestion.name[0].toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Text(
        suggestion.name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: suggestion.relation != null
          ? Text(
              suggestion.relation!,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            )
          : null,
      trailing: IconButton(
        icon: Icon(Icons.add_circle, color: Colors.blue, size: 32),
        onPressed: () => _addSuggestedMember(suggestion),
      ),
    );
  }

  Widget _buildAddedMemberCard(FamilyMember member) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: member.color,
          backgroundImage: member.avatar != null
              ? MemoryImage(member.avatar!)
              : null,
          child: member.avatar == null
              ? Text(
                  member.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        title: Text(
          member.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close, color: Colors.red),
          onPressed: () => _removeMember(member),
        ),
      ),
    );
  }

  void _addSuggestedMember(SuggestedFamilyMember suggestion) {
    setState(() {
      addedMembers.add(FamilyMember(
        id: Uuid().v4(),
        name: suggestion.name,
        avatar: suggestion.photo,
        color: _getRandomColor(),
        relation: suggestion.relation,
      ));
      suggestedMembers.remove(suggestion);
    });
  }

  void _removeMember(FamilyMember member) {
    setState(() {
      addedMembers.remove(member);
    });
  }

  void _addManualMember() async {
    final member = await showDialog<FamilyMember>(
      context: context,
      builder: (context) => AddFamilyMemberDialog(),
    );

    if (member != null) {
      setState(() {
        addedMembers.add(member);
      });
    }
  }

  void _continue() {
    // Переход к следующему шагу (выбор задач)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TasksSelectionScreen(
          familyMembers: addedMembers,
        ),
      ),
    );
  }

  Color _getRandomColor() {
    final colors = [
      Color(0xFF007AFF), // Blue
      Color(0xFF34C759), // Green
      Color(0xFFFF9500), // Orange
      Color(0xFFAF52DE), // Purple
      Color(0xFFFF2D55), // Pink
      Color(0xFF5AC8FA), // Teal
    ];
    return colors[Random().nextInt(colors.length)];
  }
}
```

---

## Варианты Onboarding Flow

### Вариант A: Простой (рекомендую)

```
Шаг 1: Welcome Screen
  ↓
Шаг 2: "Добавьте членов семьи"
  • Предложения из Contacts (если разрешение дано)
  • Ручное добавление
  ↓
Шаг 3: "Выберите задачи"
  • Библиотека задач с иконками
  • Категории: Daily, Weekly, Custom
  ↓
Шаг 4: "Назначьте задачи"
  • Drag & Drop задач на участников
  • Настройка периодичности
  ↓
Готово! → Weekly Board
```

### Вариант B: Умный (auto-create)

```
Welcome Screen показывает:

┌────────────────────────────────────────────┐
│ 👨‍👩‍👧‍👦 Мы нашли членов вашей семьи!       │
│                                            │
│ ✓ Анна (дочь)                              │
│ ✓ Максим (сын)                             │
│ ✓ Мария (жена)                             │
│                                            │
│ Создать чеклист для них?                   │
│                                            │
│ [Да, создать]  [Настроить вручную]         │
└────────────────────────────────────────────┘

Если "Да, создать":
  1. Автоматически создаем 3 Person records
  2. Предлагаем выбрать задачи из шаблонов
  3. Готовый чеклист за 30 секунд!
```

---

## Permissions & Privacy

### Info.plist

```xml
<!-- iOS: Доступ к контактам -->
<key>NSContactsUsageDescription</key>
<string>Мы предложим добавить членов семьи из ваших контактов для быстрой настройки чеклиста</string>
```

### Privacy Screen (перед запросом)

```
┌──────────────────────────────────────────────┐
│ 📇 Доступ к контактам                        │
│                                              │
│ Мы можем предложить членов семьи из ваших    │
│ контактов для быстрой настройки чеклиста     │
│                                              │
│ Ваши контакты не покидают устройство         │
│                                              │
│ [Разрешить доступ]  [Пропустить]             │
└──────────────────────────────────────────────┘
```

---

## CloudKit Sharing для приглашений

### После создания чеклиста

```dart
// lib/services/sharing_service.dart

class SharingService {
  final CloudKitService cloudKit;

  // Поделиться чеклистом
  Future<void> shareChecklist({
    required Checklist checklist,
    required List<FamilyMember> familyMembers,
  }) async {
    // 1. Проверить iCloud статус
    final iCloudAvailable = await cloudKit.isAvailable();

    if (!iCloudAvailable) {
      _showICloudRequiredDialog();
      return;
    }

    // 2. Создать CKShare
    final share = await cloudKit.createShare(checklist);

    // 3. Получить URL
    final shareUrl = share.url;

    // 4. Получить контактную информацию для умных предложений
    List<String> suggestedRecipients = [];

    for (var member in familyMembers) {
      if (member.contactId != null) {
        final contact = await FlutterContacts.getContact(member.contactId!);
        if (contact?.emails.isNotEmpty == true) {
          suggestedRecipients.add(contact!.emails.first.address);
        }
      }
    }

    // 5. Показать Share Sheet
    await Share.share(
      shareUrl,
      subject: 'Приглашение в Family Checklist',
    );

    // iOS автоматически предложит отправить через:
    // • iMessage (если есть Apple ID)
    // • Email
    // • WhatsApp
    // • Telegram
  }

  void _showICloudRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🔒 Требуется iCloud'),
        content: Text(
          'Для совместного доступа к чеклисту войдите в iCloud на этом устройстве',
        ),
        actions: [
          TextButton(
            child: Text('Отмена'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Открыть Настройки'),
            onPressed: () {
              // Открыть Settings → iCloud
              AppSettings.openAppSettings();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
```

---

## UX Flow: Sharing

### Кнопка "Поделиться" в Weekly Board

```
Пользователь нажимает "⋯" → "Поделиться"

if (iCloudEnabled) {
  // Создать share → показать Share Sheet
  showShareSheet()
} else {
  // Показать попап
  ┌──────────────────────────────────────┐
  │ 🔒 Требуется iCloud                  │
  │                                      │
  │ Для совместного доступа войдите      │
  │ в iCloud на этом устройстве          │
  │                                      │
  │ [Открыть Настройки]  [Отмена]        │
  └──────────────────────────────────────┘
}
```

### Получатель приглашения

```
1. Получает ссылку через iMessage/WhatsApp/Email
2. Тапает на ссылку
3. iOS автоматически:
   • Определяет, что это CloudKit share
   • Открывает Family Chart
   • Показывает попап "Принять приглашение?"
4. Пользователь тапает "Принять"
5. Чеклист появляется в его приложении
6. Автоматическая синхронизация включена
```

---

## Преимущества подхода

✅ **Быстрый onboarding** — 30 секунд вместо 3-5 минут
✅ **Автоматическое предложение** — не нужно вводить имена вручную
✅ **Фотографии из контактов** — визуально узнаваемо
✅ **Нативный опыт** — использует стандартные iOS компоненты
✅ **Опциональность** — можно пропустить и добавить вручную
✅ **Privacy-friendly** — контакты не покидают устройство

---

## Альтернативы (НЕ рекомендую)

### ❌ FamilyControls Framework
- Предназначен для Screen Time API
- Overkill для вашего случая
- Требует специальных разрешений

### ❌ Прямой доступ к Family Sharing группе
- Apple НЕ предоставляет API
- Нет способа получить список членов Family Sharing

---

## Implementation Roadmap

### Phase 2.4: Contacts Integration
- [ ] Интеграция Contacts Framework
- [ ] UI для умного предложения контактов
- [ ] CloudKit Sharing для приглашений
- [ ] Share Sheet интеграция

### Phase 3.3: Onboarding Implementation
- [ ] Welcome screen
- [ ] Запрос Contacts permission
- [ ] Экран добавления членов семьи
- [ ] Предложения из Contacts
- [ ] Ручное добавление

---

## Дополнительные ресурсы

- [Apple Contacts Framework](https://developer.apple.com/documentation/contacts)
- [flutter_contacts package](https://pub.dev/packages/flutter_contacts)
- [CloudKit Sharing](https://developer.apple.com/documentation/cloudkit/shared_records)
- [Share Sheet (iOS)](https://developer.apple.com/design/human-interface-guidelines/sharing)
