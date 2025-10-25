import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Supported locales
class AppLocales {
  static const en = Locale('en');
  static const ru = Locale('ru');

  static const supported = [en, ru];
  static const fallback = en;
}

/// Easy access to translations
/// Usage: LocaleKeys.common.continue.tr()
class LocaleKeys {
  static const app = _App();
  static const common = _Common();
  static const onboarding = _Onboarding();
  static const dashboard = _Dashboard();
  static const weeklyBoard = _WeeklyBoard();
  static const settings = _Settings();
  static const premium = _Premium();
  static const errors = _Errors();
  static const tasks = _Tasks();
}

class _App {
  const _App();
  String get name => 'app.name';
  String get tagline => 'app.tagline';
}

class _Common {
  const _Common();
  String get continue_ => 'common.continue';
  String get cancel => 'common.cancel';
  String get save => 'common.save';
  String get delete => 'common.delete';
  String get edit => 'common.edit';
  String get done => 'common.done';
  String get skip => 'common.skip';
  String get next => 'common.next';
  String get back => 'common.back';
  String get close => 'common.close';
  String get yes => 'common.yes';
  String get no => 'common.no';
  String get add => 'common.add';
  String get share => 'common.share';
  String get settings => 'common.settings';
}

class _Onboarding {
  const _Onboarding();
  _OnboardingWelcome get welcome => const _OnboardingWelcome();
  _OnboardingFamilyMembers get familyMembers => const _OnboardingFamilyMembers();
  _OnboardingTasks get tasks => const _OnboardingTasks();
  _OnboardingFrequency get frequency => const _OnboardingFrequency();
}

class _OnboardingWelcome {
  const _OnboardingWelcome();
  String get title => 'onboarding.welcome.title';
  String get subtitle => 'onboarding.welcome.subtitle';
  String get step1 => 'onboarding.welcome.step1';
  String get step2 => 'onboarding.welcome.step2';
  String get step3 => 'onboarding.welcome.step3';
}

class _OnboardingFamilyMembers {
  const _OnboardingFamilyMembers();
  String get title => 'onboarding.family_members.title';
  String get subtitle => 'onboarding.family_members.subtitle';
  String get suggested => 'onboarding.family_members.suggested';
  String get added => 'onboarding.family_members.added';
  String get addMember => 'onboarding.family_members.add_member';
  String get namePlaceholder => 'onboarding.family_members.name_placeholder';
}

class _OnboardingTasks {
  const _OnboardingTasks();
  String get title => 'onboarding.tasks.title';
  String get subtitle => 'onboarding.tasks.subtitle';
  String get search => 'onboarding.tasks.search';
  String get createCustom => 'onboarding.tasks.create_custom';

  _OnboardingTasksCategories get categories => const _OnboardingTasksCategories();
}

class _OnboardingTasksCategories {
  const _OnboardingTasksCategories();
  String get daily => 'onboarding.tasks.categories.daily';
  String get weekly => 'onboarding.tasks.categories.weekly';
  String get custom => 'onboarding.tasks.categories.custom';
}

class _OnboardingFrequency {
  const _OnboardingFrequency();
  String get title => 'onboarding.frequency.title';
  String get subtitle => 'onboarding.frequency.subtitle';
  String get daily => 'onboarding.frequency.daily';
  String get weekdays => 'onboarding.frequency.weekdays';
  String get weekends => 'onboarding.frequency.weekends';
  String get custom => 'onboarding.frequency.custom';
}

class _Dashboard {
  const _Dashboard();
  String get title => 'dashboard.title';
  String get activeChecklists => 'dashboard.active_checklists';
  String get createChecklist => 'dashboard.create_checklist';
  String get thisWeek => 'dashboard.this_week';
  String get today => 'dashboard.today';
  String get monthPerformance => 'dashboard.month_performance';
  String get bestTasks => 'dashboard.best_tasks';
  String get needsAttention => 'dashboard.needs_attention';
}

class _WeeklyBoard {
  const _WeeklyBoard();
  String get title => 'weekly_board.title';
  String get progress => 'weekly_board.progress';
  String get print => 'weekly_board.print';
  String get scan => 'weekly_board.scan';
  String get editChecklist => 'weekly_board.edit_checklist';

  _WeeklyBoardDays get days => const _WeeklyBoardDays();
  _WeeklyBoardDaysFull get daysFull => const _WeeklyBoardDaysFull();
}

class _WeeklyBoardDays {
  const _WeeklyBoardDays();
  String get monday => 'weekly_board.days.monday';
  String get tuesday => 'weekly_board.days.tuesday';
  String get wednesday => 'weekly_board.days.wednesday';
  String get thursday => 'weekly_board.days.thursday';
  String get friday => 'weekly_board.days.friday';
  String get saturday => 'weekly_board.days.saturday';
  String get sunday => 'weekly_board.days.sunday';
}

class _WeeklyBoardDaysFull {
  const _WeeklyBoardDaysFull();
  String get monday => 'weekly_board.days_full.monday';
  String get tuesday => 'weekly_board.days_full.tuesday';
  String get wednesday => 'weekly_board.days_full.wednesday';
  String get thursday => 'weekly_board.days_full.thursday';
  String get friday => 'weekly_board.days_full.friday';
  String get saturday => 'weekly_board.days_full.saturday';
  String get sunday => 'weekly_board.days_full.sunday';
}

class _Settings {
  const _Settings();
  String get title => 'settings.title';
  String get profile => 'settings.profile';
  String get household => 'settings.household';
  String get language => 'settings.language';
  String get weekStart => 'settings.week_start';
  String get premium => 'settings.premium';
  String get privacy => 'settings.privacy';
  String get terms => 'settings.terms';
  String get support => 'settings.support';

  _SettingsSync get sync => const _SettingsSync();
  _SettingsNotifications get notifications => const _SettingsNotifications();
}

class _SettingsSync {
  const _SettingsSync();
  String get title => 'settings.sync.title';
  String get description => 'settings.sync.description';
  String get lastSync => 'settings.sync.last_sync';
  String get devices => 'settings.sync.devices';
  String get enable => 'settings.sync.enable';
  String get disable => 'settings.sync.disable';
}

class _SettingsNotifications {
  const _SettingsNotifications();
  String get title => 'settings.notifications.title';
  String get morningReminder => 'settings.notifications.morning_reminder';
  String get eveningReview => 'settings.notifications.evening_review';
  String get weeklySummary => 'settings.notifications.weekly_summary';
}

class _Premium {
  const _Premium();
  String get title => 'premium.title';
  String get restore => 'premium.restore';
  String trial(int days) => 'premium.trial'.tr(namedArgs: {'days': days.toString()});

  _PremiumFeatures get features => const _PremiumFeatures();
  _PremiumPlans get plans => const _PremiumPlans();
}

class _PremiumFeatures {
  const _PremiumFeatures();
  String get ocr => 'premium.features.ocr';
  String get voice => 'premium.features.voice';
  String get members => 'premium.features.members';
  String get history => 'premium.features.history';
  String get reports => 'premium.features.reports';
}

class _PremiumPlans {
  const _PremiumPlans();
  String get monthly => 'premium.plans.monthly';
  String get yearly => 'premium.plans.yearly';
  String get lifetime => 'premium.plans.lifetime';
}

class _Errors {
  const _Errors();
  String get generic => 'errors.generic';
  String get network => 'errors.network';
  String get icloudRequired => 'errors.icloud_required';
  String get permissionDenied => 'errors.permission_denied';
}

class _Tasks {
  const _Tasks();
  String get cleanRoom => 'tasks.clean_room';
  String get makeBed => 'tasks.make_bed';
  String get brushTeeth => 'tasks.brush_teeth';
  String get homework => 'tasks.homework';
  String get walkDog => 'tasks.walk_dog';
  String get dishes => 'tasks.dishes';
  String get laundry => 'tasks.laundry';
  String get vacuum => 'tasks.vacuum';
  String get trash => 'tasks.trash';
  String get waterPlants => 'tasks.water_plants';
}
