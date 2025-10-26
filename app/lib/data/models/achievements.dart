import 'package:isar/isar.dart';

part 'achievements.g.dart';

/// Achievements model - tracks user achievements and milestones
@collection
class Achievements {
  Id achievementId = Isar.autoIncrement; // Primary key, auto-increment

  @Index()
  late int userId; // FK to Users

  int? checklistId; // FK to Checklists (optional)

  @Enumerated(EnumType.name)
  late AchievementType type;

  late String title; // Achievement title (e.g., "5 days in a row!")

  String? description; // Achievement description

  late String iconName; // Icon identifier

  late DateTime earnedAt; // Exact date and time earned

  late DateTime earnedDate; // Day earned (without time, for grouping)

  @Index()
  late int weekNumber; // Week number when earned

  @Index()
  late int weekYear; // Year when earned

  String? metadata; // JSON with additional data
}

/// Achievement types
enum AchievementType {
  streak5days, // 5 days in a row
  week100percent, // 100% completion for a week
  team90percent, // Team achieved 90%+ for a week
  custom, // Custom achievement
}
