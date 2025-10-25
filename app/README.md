# Family Chart — Flutter App

Habits & Chores tracker for families with kids.

## Tech Stack

- **State Management:** Riverpod
- **Database:** Isar (NoSQL, offline-first)
- **Routing:** go_router
- **UI:** Material 3 + Custom Liquid Design

См. полную документацию: [../docs/tech-stack.md](../docs/tech-stack.md)

---

## Setup

### 1. Установка зависимостей

```bash
flutter pub get
```

### 2. Code Generation

```bash
# Первый запуск
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (для разработки)
flutter pub run build_runner watch
```

### 3. Запуск приложения

```bash
# iOS
flutter run

# Android
flutter run

# С выбором устройства
flutter run -d <device_id>
```

---

## Структура проекта

```
lib/
├── core/                      # Общие компоненты
│   ├── constants/            # Константы
│   ├── providers/            # Глобальные providers (Isar, Router)
│   ├── theme/                # Тема
│   └── utils/                # Утилиты
│
├── data/                      # Слой данных
│   ├── models/               # Isar модели
│   ├── repositories/         # Репозитории
│   └── datasources/          # CloudKit, Firebase
│
├── features/                  # Функциональные модули
│   ├── onboarding/
│   ├── dashboard/
│   ├── weekly_board/
│   └── settings/
│
└── main.dart
```

---

## Полезные команды

```bash
# Проверка кода
flutter analyze

# Форматирование
flutter format .

# Тесты
flutter test

# Очистка
flutter clean

# Обновление зависимостей
flutter pub upgrade
```

---

## Firebase Setup

1. Установить FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Сконфигурировать Firebase:
```bash
flutterfire configure --project=family-chart-b6c1d
```

---

## Документация

- [Development Plan](../docs/development-plan.md)
- [Tech Stack](../docs/tech-stack.md)
- [Product Requirements](../docs/product-requirements.md)
- [CloudKit Sync Architecture](../docs/feature-sync-architecture.md)
- [Contacts Integration](../docs/feature-family-sharing-integration.md)

---

## Current Status

✅ **Phase 2 Complete** — Подготовка и проектирование

**Следующий шаг:** Phase 3 — MVP разработка
