import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/settings.dart';

part 'settings_repository.g.dart';

/// Repository for settings operations
@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return SettingsRepository(isar);
}

class SettingsRepository {
  final Isar _isar;

  SettingsRepository(this._isar);

  /// Get setting by key
  Future<String?> get(String key) async {
    final setting =
        await _isar.settings.filter().settingKeyEqualTo(key).findFirst();
    return setting?.settingValue;
  }

  /// Set setting value
  Future<void> set(String key, String value) async {
    final existing =
        await _isar.settings.filter().settingKeyEqualTo(key).findFirst();

    final now = DateTime.now();

    if (existing != null) {
      // Update existing
      existing.settingValue = value;
      existing.modifiedAt = now;

      await _isar.writeTxn(() async {
        await _isar.settings.put(existing);
      });
    } else {
      // Create new
      final setting = Settings()
        ..settingKey = key
        ..settingValue = value
        ..modifiedAt = now;

      await _isar.writeTxn(() async {
        await _isar.settings.put(setting);
      });
    }
  }

  /// Get setting with default value
  Future<String> getOrDefault(String key, String defaultValue) async {
    final value = await get(key);
    return value ?? defaultValue;
  }

  /// Get boolean setting
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final value = await get(key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  /// Set boolean setting
  Future<void> setBool(String key, bool value) async {
    await set(key, value.toString());
  }

  /// Delete setting
  Future<void> delete(String key) async {
    final setting =
        await _isar.settings.filter().settingKeyEqualTo(key).findFirst();
    if (setting == null) return;

    await _isar.writeTxn(() async {
      await _isar.settings.delete(setting.id);
    });
  }

  /// Get all settings
  Future<Map<String, String>> getAll() async {
    final settings = await _isar.settings.where().findAll();
    return {for (var s in settings) s.settingKey: s.settingValue};
  }

  /// Initialize default settings
  Future<void> initializeDefaults() async {
    final defaults = {
      SettingKeys.weekStartDay: 'monday',
      SettingKeys.language: 'en',
      SettingKeys.notificationMorningTime: '07:30',
      SettingKeys.notificationEveningTime: '19:30',
      SettingKeys.notificationEnabled: 'false',
      SettingKeys.onboardingCompleted: 'false',
      SettingKeys.cloudKitEnabled: 'false',
    };

    for (var entry in defaults.entries) {
      final existing = await get(entry.key);
      if (existing == null) {
        await set(entry.key, entry.value);
      }
    }
  }

  /// Watch setting value (stream)
  Stream<String?> watch(String key) {
    return _isar.settings
        .filter()
        .settingKeyEqualTo(key)
        .watch(fireImmediately: true)
        .map((settings) => settings.isNotEmpty ? settings.first.settingValue : null);
  }
}

/// Provider to get week start day setting
/// Returns 'monday' or 'sunday', defaults to 'monday'
@riverpod
Future<String> weekStartDay(WeekStartDayRef ref) async {
  final isar = await ref.watch(isarProvider.future);

  // Load all settings using count + get pattern (compatible with Isar 3.1.0+1)
  final allSettings = <Settings>[];
  final count = await isar.settings.count();
  for (var i = 1; i <= count + 100; i++) {
    final setting = await isar.settings.get(i);
    if (setting != null) {
      allSettings.add(setting);
    }
  }

  final weekStartSetting = allSettings.cast<Settings?>().firstWhere(
    (s) => s?.settingKey == SettingKeys.weekStartDay,
    orElse: () => null,
  );

  return weekStartSetting?.settingValue ?? 'monday';
}
