# Family Chart

**Habit tracker and chore management app for families with kids**

---

## 📁 Структура проекта

```
family-checklist/
├── app/                    # 📱 Flutter приложение (iOS/Android)
│   └── (будет создано через flutter create)
│
├── docs/                   # 📄 Документация
│   ├── development-plan.md           # План разработки
│   ├── product-requirements.md       # Требования к продукту
│   ├── premium-readme.md             # Premium функции
│   └── html-prototypes-summary.md    # Описание HTML прототипов
│
├── prototypes/             # 🎨 HTML прототипы (Фаза 1)
│   ├── demo.html                     # Навигационный hub
│   ├── demo-onboarding.html          # Онбординг
│   ├── demo-dashboard.html           # Dashboard
│   ├── demo-weekly-board.html        # Weekly Board
│   ├── demo-ipad.html                # iPad версия
│   ├── data/                         # JSON демо данные
│   ├── images/                       # Иконки для прототипов
│   └── README.md
│
└── landings/               # 🌐 Landing pages
    ├── family-checklist.com/
    │   ├── index.html
    │   ├── privacy.html
    │   ├── terms.html
    │   ├── robots.txt
    │   └── sitemap.xml
    ├── chore-chart.app/
    ├── teachkidshabits.com/
    └── index.html
```

---

## 🚀 Быстрый старт

### Просмотр HTML прототипов

```bash
cd prototypes/
open http://localhost/family-checklist/prototypes/demo.html
```

### Разработка Flutter приложения

```bash
# Обновить Flutter
flutter upgrade

# Создать Flutter проект (выполнить один раз)
cd /private/var/www/family-checklist/
flutter create --org com.familychart --project-name family_chart --platforms ios,android app

# Запустить приложение
cd app/
flutter run
```

---

## 📖 Документация

- **[Development Plan](docs/development-plan.md)** — общий план разработки проекта
- **[Product Requirements](docs/product-requirements.md)** — требования к продукту (PRD)
- **[HTML Prototypes Summary](docs/html-prototypes-summary.md)** — полное описание прототипов
- **[Premium Features](docs/premium-readme.md)** — описание Premium функций

---

## 🎯 Текущий статус

### ✅ Фаза 1: HTML-прототипирование — **ЗАВЕРШЕНА**
- Onboarding (4 экрана + paywall)
- Dashboard (главный экран с аналитикой)
- Weekly Board (таблица задач)
- iPad версия
- Навигация между экранами

### 🚧 Фаза 2: Подготовка Flutter проекта — **В ПРОЦЕССЕ**
- [ ] Обновить Flutter до latest stable
- [ ] Создать Flutter проект
- [ ] Настроить Firebase (Remote Config, Analytics)
- [ ] Настроить Amplitude
- [ ] Определить архитектуру (Riverpod, go_router, Hive)

### ⏭️ Фаза 3: MVP разработка
- Weekly Board функционал
- Локальное хранение (Hive/Isar)
- Базовый онбординг

---

## 🛠 Технологический стек

### Frontend
- **Framework:** Flutter 3.24+
- **State Management:** Riverpod (планируется)
- **Routing:** go_router
- **Local Storage:** Hive / Isar
- **UI:** Material 3 + iOS design system

### Backend & Services
- **Remote Config:** Firebase Remote Config
- **Analytics:** Amplitude + Firebase Analytics
- **Cloud Sync:** iCloud CloudKit (v1)
- **Auth:** Apple Sign In

### Monetization
- **Subscriptions:** RevenueCat
- **Pricing:** Free tier + Premium ($2.99/мес или $24.99/год)

---

## 📝 Ключевые концепции

**Целевая аудитория:** Семьи с детьми 6-12 лет

**Основная ценность:** Визуальная система управления домашними задачами и рутиной с возможностью совместного ведения

**Core Features:**
- Weekly Board (таблица люди × задачи × дни)
- Библиотека задач с иконками
- Печать A4 с OCR распознаванием
- Синхронизация между устройствами (Premium)
- Голосовой ввод задач с AI (Premium)

---

## 🔗 Полезные ссылки

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [RevenueCat Dashboard](https://app.revenuecat.com/)
- [App Store Connect](https://appstoreconnect.apple.com/)

---

*Последнее обновление: October 25, 2025*
*Проект: Family Chart — Habits & Chores Tracker*
