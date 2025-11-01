// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsRepositoryHash() =>
    r'188da5b01daa504f5fc3256068bfc19dad8f769a';

/// Repository for settings operations
///
/// Copied from [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider =
    AutoDisposeProvider<SettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SettingsRepositoryRef = AutoDisposeProviderRef<SettingsRepository>;
String _$weekStartDayHash() => r'1a20a448d27989adc805ba021f34d3b5c30f463f';

/// Provider to get week start day setting
/// Returns 'monday' or 'sunday', defaults to 'monday'
///
/// Copied from [weekStartDay].
@ProviderFor(weekStartDay)
final weekStartDayProvider = AutoDisposeFutureProvider<String>.internal(
  weekStartDay,
  name: r'weekStartDayProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$weekStartDayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeekStartDayRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
