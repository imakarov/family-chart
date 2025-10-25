# Family Chart — Setup Guide

Руководство по настройке проекта Family Chart

---

## ✅ Выполнено (Фаза 2.1)

### 1. Реорганизация структуры проекта ✅
```
family-checklist/
├── app/                  # Flutter приложение
├── docs/                 # Документация
├── prototypes/           # HTML прототипы + данные
└── landings/             # Landing pages
```

### 2. Создан Flutter проект ✅
- **Организация:** com.oneclue
- **Название:** family_chart
- **Bundle ID:** `com.oneclue.familychart`
- **Платформы:** iOS, Android

### 3. Создан project-config.yaml ✅
Конфигурационный файл со всеми credentials:
- Firebase Project ID: `family-chart-b6c1d`
- Amplitude API Key: `x_aRUdKIw3Xqiny7Uvgi8PLsZnf53PVO`
- Bundle ID: `com.oneclue.familychart`

### 4. Зарегистрированы приложения в Firebase ✅
**iOS App:**
- App ID: `1:45095178419:ios:155cce57c6508d0a6d20c6`
- Bundle ID: `com.oneclue.familychart`
- ✅ GoogleService-Info.plist → `app/ios/Runner/`

**Android App:**
- App ID: `1:45095178419:android:6e3b1451c83a921e6d20c6`
- Package name: `com.oneclue.familychart`
- ✅ google-services.json → `app/android/app/`

---

## 📋 Следующие шаги

### Шаг 1: Установить FlutterFire CLI

```bash
# Установить FlutterFire CLI
dart pub global activate flutterfire_cli

# Добавить в PATH (если нужно)
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Проверить установку
flutterfire --version
```

---

### Шаг 2: Настроить Firebase в Flutter проекте

```bash
cd /private/var/www/family-checklist/app

# Запустить конфигурацию
flutterfire configure --project=family-chart-b6c1d

# Выбрать платформы: iOS, Android
# FlutterFire CLI автоматически создаст firebase_options.dart
```

---

### Шаг 3: Добавить базовые зависимости

```bash
cd /private/var/www/family-checklist/app

# State Management & Routing
flutter pub add flutter_riverpod
flutter pub add go_router

# Local Storage
flutter pub add hive hive_flutter
flutter pub add path_provider

# Firebase
flutter pub add firebase_core
flutter pub add firebase_remote_config
flutter pub add firebase_analytics

# Amplitude Analytics
flutter pub add amplitude_flutter

# Utilities
flutter pub add intl
flutter pub add logger
flutter pub add freezed_annotation
flutter pub add json_annotation
flutter pub add uuid

# Dev Dependencies
flutter pub add -d build_runner
flutter pub add -d freezed
flutter pub add -d json_serializable
flutter pub add -d flutter_lints
```

---

### Шаг 4: Создать базовую архитектуру папок

```bash
cd /private/var/www/family-checklist/app/lib

# Создать структуру
mkdir -p app/{router,theme}
mkdir -p core/{constants,utils,extensions,widgets}
mkdir -p features/{onboarding,dashboard,weekly_board,settings}/{data,domain,presentation}
mkdir -p services

# Создать базовые файлы
touch app/app.dart
touch app/router/app_router.dart
touch app/theme/app_theme.dart
touch core/constants/app_constants.dart
touch services/firebase_service.dart
touch services/amplitude_service.dart
```

---

### Шаг 5: Настроить Firebase Remote Config

В Firebase Console → Remote Config → Add parameter:

```json
{
  "paywall_monthly_price_usd": 2.99,
  "paywall_yearly_price_usd": 24.99,
  "paywall_lifetime_price_usd": 99.99,
  "paywall_monthly_price_inr": 149,
  "paywall_yearly_price_inr": 999,
  "paywall_lifetime_price_inr": 2999,
  "free_member_limit": 3,
  "free_task_per_member_limit": 3,
  "premium_member_limit": 6,
  "trial_days_monthly": 3,
  "trial_days_yearly": 7,
  "feature_voice_input_enabled": false,
  "feature_ocr_enabled": false
}
```

---

## 🔑 Важная информация

### Bundle ID / Package Name
```
iOS:     com.oneclue.familychart
Android: com.oneclue.familychart
```

**ВАЖНО:** Используется `oneclue` вместо `1clue`, потому что package name не может начинаться с цифры.

### Firebase Project
```
Project Name: Family-Chart
Project ID:   family-chart-b6c1d
Project #:    45095178419
```

### Amplitude
```
API Key: x_aRUdKIw3Xqiny7Uvgi8PLsZnf53PVO
```

---

## 📁 Структура Flutter проекта

После выполнения всех шагов:

```
app/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart        # Создается FlutterFire CLI
│   ├── app/
│   │   ├── app.dart
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   └── theme/
│   │       └── app_theme.dart
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── utils/
│   │   ├── extensions/
│   │   └── widgets/
│   ├── features/
│   │   ├── onboarding/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── dashboard/
│   │   ├── weekly_board/
│   │   └── settings/
│   └── services/
│       ├── firebase_service.dart
│       └── amplitude_service.dart
├── android/
│   └── app/
│       └── google-services.json     # Из Firebase Console
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist  # Из Firebase Console
└── pubspec.yaml
```

---

## 🧪 Проверка работоспособности

После настройки проверьте:

```bash
cd /private/var/www/family-checklist/app

# Проверить зависимости
flutter pub get

# Проверить что проект компилируется
flutter analyze

# Запустить на симуляторе
flutter run
```

---

## 📚 Полезные ссылки

- **Firebase Console:** https://console.firebase.google.com/project/family-chart-b6c1d
- **Amplitude Dashboard:** https://analytics.amplitude.com/
- **FlutterFire Docs:** https://firebase.flutter.dev/
- **Riverpod Docs:** https://riverpod.dev/
- **Go Router Docs:** https://pub.dev/packages/go_router
- **Hive Docs:** https://docs.hivedb.dev/

---

## ⚠️ ВАЖНО: Что НЕ коммитить в Git

Создайте `.gitignore` в корне проекта:

```
# Firebase Config Files (содержат sensitive data)
app/ios/Runner/GoogleService-Info.plist
app/android/app/google-services.json
app/lib/firebase_options.dart

# Amplitude API Keys (уже в project-config.yaml, который тоже не в git!)
project-config.yaml

# Flutter
app/.dart_tool/
app/.packages
app/pubspec.lock
app/build/

# IDE
.idea/
.vscode/
*.swp
*.iml
.DS_Store
```

**Примечание:** `project-config.yaml` содержит все credentials и НЕ должен коммититься в публичный репозиторий!

---

*Последнее обновление: October 25, 2025*
*Статус: Фаза 2.1 — Flutter проект создан, ожидается настройка Firebase*
