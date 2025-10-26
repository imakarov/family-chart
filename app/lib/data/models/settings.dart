import 'package:isar/isar.dart';

part 'settings.g.dart';

/// Settings model - global app settings (key-value store)
@collection
class Settings {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String settingKey; // Setting name (unique)

  late String settingValue; // Setting value

  late DateTime modifiedAt;
}

/// Predefined setting keys
class SettingKeys {
  static const String weekStartDay = 'week_start_day'; // "monday" or "sunday"
  static const String language = 'language'; // "ru" or "en"
  static const String notificationMorningTime = 'notification_morning_time'; // "07:30"
  static const String notificationEveningTime = 'notification_evening_time'; // "19:30"
  static const String notificationEnabled = 'notification_enabled'; // "true" or "false"
  static const String onboardingCompleted = 'onboarding_completed'; // "true" or "false"
  static const String cloudKitEnabled = 'cloudkit_enabled'; // "true" or "false"
}
