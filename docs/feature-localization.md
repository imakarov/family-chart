# Localization Guide — Family Chart

## Обзор

Family Chart поддерживает мультиязычность с помощью **`easy_localization`**.

**Поддерживаемые языки:**
- 🇬🇧 English (EN)
- 🇷🇺 Русский (RU)

**Fallback:** English

---

## Структура файлов

```
app/
├── assets/
│   └── translations/
│       ├── en.json      # Английский
│       └── ru.json      # Русский
│
└── lib/
    └── core/
        └── utils/
            └── localization_helper.dart  # Type-safe ключи
```

---

## Как использовать

### 1. Type-safe подход (рекомендуется)

```dart
import 'package:easy_localization/easy_localization.dart';
import 'core/utils/localization_helper.dart';

// В виджете
Text(LocaleKeys.dashboard.title.tr())

// С кнопкой
ElevatedButton(
  onPressed: () {},
  child: Text(LocaleKeys.common.continue_.tr()),
)

// С параметрами
Text(LocaleKeys.premium.trial(7).tr())
// Результат: "Start 7-Day Free Trial" (EN)
//            "Начать 7-дневную пробную версию" (RU)
```

### 2. String подход (быстрый)

```dart
Text('dashboard.title'.tr())
Text('common.continue'.tr())
```

---

## Примеры использования

### Базовый пример

```dart
class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.dashboard.title.tr()),
      ),
      body: Column(
        children: [
          Text(LocaleKeys.dashboard.activeChecklists.tr()),
          ElevatedButton(
            onPressed: () {},
            child: Text(LocaleKeys.dashboard.createChecklist.tr()),
          ),
        ],
      ),
    );
  }
}
```

### С параметрами

```dart
// JSON:
// "settings.sync.last_sync": "Last sync: {time}"

Text(
  'settings.sync.last_sync'.tr(namedArgs: {
    'time': '2 min ago',
  }),
)
// Результат: "Last sync: 2 min ago"
```

### Plural forms

```dart
// JSON:
// "items": {
//   "zero": "No items",
//   "one": "{} item",
//   "other": "{} items"
// }

Text('items'.plural(count))
```

---

## Смена языка

### В настройках приложения

```dart
// Settings Screen
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(LocaleKeys.settings.language.tr()),
      trailing: DropdownButton<Locale>(
        value: context.locale,
        items: [
          DropdownMenuItem(
            value: AppLocales.en,
            child: Text('🇬🇧 English'),
          ),
          DropdownMenuItem(
            value: AppLocales.ru,
            child: Text('🇷🇺 Русский'),
          ),
        ],
        onChanged: (locale) {
          if (locale != null) {
            context.setLocale(locale);
          }
        },
      ),
    );
  }
}
```

### Автоматическое определение языка устройства

```dart
// main.dart - уже настроено
EasyLocalization(
  supportedLocales: AppLocales.supported,  // [en, ru]
  fallbackLocale: AppLocales.fallback,     // en
  // Автоматически определит язык устройства
  child: MyApp(),
)
```

---

## Добавление новых переводов

### 1. Добавить в JSON файлы

**en.json:**
```json
{
  "new_feature": {
    "title": "New Feature",
    "description": "This is a new feature"
  }
}
```

**ru.json:**
```json
{
  "new_feature": {
    "title": "Новая функция",
    "description": "Это новая функция"
  }
}
```

### 2. Добавить в localization_helper.dart

```dart
class LocaleKeys {
  // ...
  static const newFeature = _NewFeature();
}

class _NewFeature {
  const _NewFeature();
  String get title => 'new_feature.title';
  String get description => 'new_feature.description';
}
```

### 3. Использовать

```dart
Text(LocaleKeys.newFeature.title.tr())
```

---

## Добавление нового языка

### 1. Создать файл перевода

```bash
touch app/assets/translations/es.json  # Испанский
```

### 2. Добавить в AppLocales

```dart
// lib/core/utils/localization_helper.dart

class AppLocales {
  static const en = Locale('en');
  static const ru = Locale('ru');
  static const es = Locale('es');  // Добавить

  static const supported = [en, ru, es];  // Добавить в список
  static const fallback = en;
}
```

### 3. Заполнить переводы

Скопировать структуру из `en.json` и перевести на испанский.

---

## Firebase Remote Config интеграция

Можно управлять языком через Remote Config:

```dart
final remoteConfig = FirebaseRemoteConfig.instance;
await remoteConfig.fetchAndActivate();

final forcedLocale = remoteConfig.getString('forced_locale');

if (forcedLocale.isNotEmpty) {
  final locale = Locale(forcedLocale);
  context.setLocale(locale);
}
```

---

## Best Practices

### ✅ Рекомендуется

- Использовать `LocaleKeys` для type safety
- Группировать переводы по feature (onboarding, dashboard, etc.)
- Использовать параметры для динамического контента
- Тестировать оба языка перед релизом

### ❌ Не рекомендуется

- Хардкодить текст в виджетах
- Использовать string concatenation для переводов
- Забывать про plural forms
- Смешивать английский и русский в UI

---

## Тестирование

### Переключение языка в runtime

```dart
// Для тестирования
ElevatedButton(
  onPressed: () {
    final currentLocale = context.locale;
    final newLocale = currentLocale == AppLocales.en
        ? AppLocales.ru
        : AppLocales.en;
    context.setLocale(newLocale);
  },
  child: Text('Switch Language'),
)
```

### Проверка missing translations

```bash
# Сравнить ключи в en.json и ru.json
# Если ключ отсутствует, будет показан fallback (EN)
```

---

## Hot Reload

`easy_localization` поддерживает hot reload!

После изменения JSON файлов:
1. Сохраните файл
2. Hot reload в Flutter (R)
3. Переводы обновятся автоматически

---

## Производительность

- Переводы загружаются **при старте приложения**
- Кэшируются в памяти
- Смена языка = instant (без перезагрузки)

---

## Полезные команды

```dart
// Получить текущий язык
final currentLocale = context.locale;  // en или ru

// Проверить поддерживается ли язык
final isSupported = context.supportedLocales.contains(locale);

// Получить язык устройства
final deviceLocale = context.deviceLocale;

// Сбросить на fallback
context.resetLocale();
```

---

## Ссылки

- [easy_localization на pub.dev](https://pub.dev/packages/easy_localization)
- [Документация](https://easy-localization.netlify.app/)
- [JSON структура](../../app/assets/translations/en.json)
