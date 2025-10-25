# HTML Prototypes — Family Chart

HTML прототипы интерфейсов приложения Family Chart (Фаза 1).

## 📋 Содержимое

### HTML файлы

- **demo.html** — стартовая страница для тестирования прототипов
- **demo-onboarding.html** — онбординг (4 экрана + paywall)
- **demo-dashboard.html** — главный экран с аналитикой
- **demo-weekly-board.html** — недельная таблица задач
- **demo-ipad.html** — iPad версия (горизонтальная)
- **index.html** — старая версия viewer (deprecated, использовать demo.html)

### Данные (data/)

- **onboarding-tasks.json** — библиотека задач для онбординга
- **weekly-board-data.json** — демо данные для недельной таблицы
- **dashboard-data.json** — демо данные для dashboard
- **demo-ipad-data.json** — демо данные для iPad версии

## 🚀 Как использовать

### Локальный просмотр (с HTTP сервером)

```bash
# Python 3
cd prototypes/
python3 -m http.server 8899

# Открыть в браузере
open http://localhost:8899/demo.html
```

### Навигация между экранами

```
demo.html (start)
  ↓
demo-onboarding.html → Paywall → demo-weekly-board.html
                                        ↓ (back ‹)
                                  demo-dashboard.html
                                        ↓ (Open Chart)
                                  demo-weekly-board.html
                                        ↓ (Edit buttons)
                                  demo-onboarding.html?step=1/2/3
```

## 📚 Документация

Полное описание прототипов см. в `/docs/html-prototypes-summary.md`

## ⚠️ Важно

Эти прототипы созданы для:
- Визуализации концепции UI/UX
- Согласования дизайна перед разработкой Flutter приложения
- Демонстрации навигационных flow

**Не использовать** в продакшене. Для разработки см. `/app/` (Flutter проект).

---

*Создано: October 2025*
*Статус: ✅ Фаза 1 завершена*
