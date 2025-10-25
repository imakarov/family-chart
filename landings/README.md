# Family Checklist — Landing Page

## 📋 О странице

Лендинг для привлечения пользователей на Early Access программу Family Checklist. Основан на методологии Jobs-to-be-Done (JTBD).

**Основное обещание:** Grow Responsibility Together — родители показывают пример, дети учатся ответственности через видимый общий прогресс.

### Интерактивное демо

Лендинг включает полноценное интерактивное демо через iframe, загружающий `../demo-ipad.html`. Это позволяет:
- Использовать весь функционал оригинального демо (звездочки, статусы дней, клики)
- Избежать дублирования кода
- Легко обновлять демо независимо от лендинга

## 🎯 Целевая аудитория

- Родители детей 6-14 лет
- Семьи, где 1-3 детские привычки "не даются"
- Ситуации: начало учебного года, смена режима, необходимость выстроить рутину

## 📊 Структура страницы

1. **Hero** — Grow Responsibility Together
2. **Why it works** — Почему видимость эффективнее напоминаний
3. **Three Pillars** — Health, Home, Future
4. **How it works** — 3 шага использования
5. **For Parents** — Ключевые возможности для взрослых
6. **FAQ** — 6 основных вопросов
7. **Bottom CTA** — Ready to grow together?

## 📧 Формы

### Early Access Form
- Email (обязательно)
- Платформа: iOS/Android (опционально)
- Согласие на email-рассылку (обязательно)
- Отправка на: `webclue@gmail.com`

### Contact Form
- Name, Email, Message (все обязательно)
- Отправка на: `webclue@gmail.com`

### Защита от спама
- Honeypot поле
- reCAPTCHA через FormSubmit
- Email валидация на фронтенде

## 📈 Аналитика (Яндекс.Метрика 104570658)

### Отслеживаемые события:
- `subscribe_click` — клик по CTA (с location: top/hero/bottom)
- `subscribe_success` — успешная подписка
- `contact_submit` — отправка контактной формы
- `scroll_50` — прокрутка страницы на 50%+
- `hero_view` — просмотр Hero секции (IntersectionObserver)
- `faq_open` — открытие FAQ вопроса

### UTM параметры
Автоматически захватываются и сохраняются:
- utm_source, utm_medium, utm_campaign, utm_content, utm_term
- Сохранение в localStorage (`fc_leads`)
- Передача в скрытых полях форм

## 🎨 Дизайн

**Стиль:** iOS-like, минималистичный
- Белый фон (#FFFFFF)
- Основной цвет: #007AFF (Apple Blue)
- Шрифт: -apple-system, San Francisco
- Скругления: 16px (карточки), 24px (большие блоки)
- Тени: мягкие, прозрачность 4-8%
- Backdrop blur для top bar

**Адаптивность:**
- Мобильные: 375-430px
- Планшеты: 768px+
- Десктоп: до 1200px container

## 🚀 Развертывание

### Локальный запуск
```bash
# Просто откройте index.html в браузере
open landings/index.html
```

### Публикация
Рекомендуемые платформы:
- **Netlify** (рекомендуется)
  - Drag & Drop развертывание
  - Бесплатный SSL
  - Поддержка FormSubmit
  
- **Vercel**
- **GitHub Pages**

### Настройка домена
Убедитесь, что обновили canonical URL и OG tags:
```html
<link rel="canonical" href="https://family-checklist.com/">
<meta property="og:url" content="https://family-checklist.com/">
```

## ✅ Чеклист приемки (из ТЗ п.10)

### Контент
- [x] Все тексты из п.3 ТЗ воспроизведены без изменений
- [x] Hero: H1, Sub, CTA, Microcopy
- [x] Why it works: заголовок + текст
- [x] Three Pillars: Health, Home, Future с описаниями
- [x] How it works: 3 шага + footnote о печати
- [x] For Parents: 5 буллетов
- [x] FAQ: 6 вопросов
- [x] Bottom CTA с текстом и микрокопи

### Формы
- [x] Early Access форма отправляет на webclue@gmail.com
- [x] Contact форма отправляет на webclue@gmail.com
- [x] Скрытые поля: page, utm_* параметры
- [x] Honeypot поле для антиспама
- [x] Email валидация на фронтенде
- [x] Сообщения успеха/ошибки
- [x] Согласие на рассылку (обязательный чекбокс)

### Аналитика
- [x] Яндекс.Метрика 104570658 установлена
- [x] window.__ymId = 104570658
- [x] Цели: subscribe_click, subscribe_success
- [x] Цели: contact_submit, scroll_50
- [x] Цели: hero_view (IntersectionObserver)
- [x] Цели: faq_open
- [x] UTM параметры захватываются
- [x] UTM сохраняются в localStorage

### SEO/OG
- [x] Title: Family Checklist — Grow Responsibility Together (≤60 символов)
- [x] Description: ≤160 символов
- [x] Canonical URL
- [x] OG tags (title, description, type, url, image)
- [x] robots.txt открыт
- [x] sitemap.xml создан

### Дизайн/UX
- [x] iOS-like стиль: белый фон, чистые карточки
- [x] Фиксированная top-bar с CTA
- [x] Backdrop blur на top-bar
- [x] CTA в Hero и внизу страницы
- [x] Адаптивность для мобильных (375-430px)
- [x] Крупный H1, читаемые тексты
- [x] Иконки/эмодзи для Health/Home/Future понятны

### Футер
- [x] Privacy Policy доступна
- [x] Terms of Service доступны
- [x] Email контакт: webclue@gmail.com

### Производительность
- [ ] PageSpeed Mobile ≥90 (требует проверки после публикации)
- [ ] LCP < 2.0s (проверить после публикации)
- [ ] CLS < 0.1 (проверить после публикации)
- [ ] TBT < 200ms (проверить после публикации)

**Примечание:** Производительность проверяется на реальном хостинге через PageSpeed Insights.

## 🎯 KPI (первый спринт)

Отслеживать в Яндекс.Метрике:

1. **CTR по CTA:** ≥ 6-10%
   - Формула: (Клики на CTA / Сеансы) × 100%
   - События: subscribe_click

2. **Конверсия подписки:** ≥ 25-35%
   - Формула: (subscribe_success / subscribe_click) × 100%

3. **Scroll depth ≥50%:** ≥ 55% сессий
   - События: scroll_50

4. **Mobile LCP ≤2.0s:** ≥ 85% сессий
   - Проверка через PageSpeed Insights

## 🔄 Варианты A/B тестирования (из ТЗ п.9)

Для будущих экспериментов подготовлены 3 варианта Hero:

**Вариант A** (текущий):
- H1: Grow Responsibility Together
- Sub: Kids learn by watching you...

**Вариант B** (детский акцент):
- H1: Teach Kids Habits — the Family Way
- Sub: Visible routines, daily checkmarks...

**Вариант C** (прогресс):
- H1: From chores to character
- Sub: Make responsibility visible...

## 📝 TODO после публикации

1. Создать OG image (1200×630px)
2. Настроить real domain (заменить family-checklist.com)
3. Протестировать формы на реальной отправке
4. Запустить PageSpeed Insights
5. Настроить дашборд в Яндекс.Метрике
6. Провести A/B тест вариантов Hero

## 📞 Контакты

**Email:** webclue@gmail.com

## 📄 Лицензия

© 2025 Family Checklist. All rights reserved.

