/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Family Chart';
  static const String appVersion = '1.0.0';

  // Free Tier Limits
  static const int freeMaxHouseholds = 1;
  static const int freeMaxMembers = 3;
  static const int freeMaxTasksPerMember = 3;

  // Premium Tier Limits
  static const int premiumMaxHouseholds = 3;
  static const int premiumMaxMembers = 6;
  static const int premiumMaxTasksPerMember = -1; // unlimited

  // Timing
  static const Duration syncInterval = Duration(seconds: 30);
  static const Duration sessionTimeout = Duration(minutes: 5);

  // Routes
  static const String routeHome = '/';
  static const String routeOnboarding = '/onboarding';
  static const String routeWeeklyBoard = '/checklist/:id';
  static const String routeSettings = '/settings';
}
