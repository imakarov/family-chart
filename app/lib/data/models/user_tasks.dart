import 'package:isar/isar.dart';

part 'user_tasks.g.dart';

/// UserTasks model - links Users + Tasks + Checklists with frequency settings
@collection
class UserTasks {
  Id id = Isar.autoIncrement; // Auto-increment ID

  @Index()
  late int userId; // FK to Users

  @Index()
  late int taskId; // FK to Tasks

  @Index()
  late int checklistId; // FK to Checklists

  /// Frequency: days of week as comma-separated string
  /// Examples:
  /// - "1,2,3,4,5" = Mon-Fri
  /// - "6,7" = weekends
  /// - "1,3,5" = Mon/Wed/Fri
  /// - "1,2,3,4,5,6,7" = every day
  /// Where: 1=Mon, 2=Tue, ..., 7=Sun (ISO 8601)
  late String frequency;

  late int sortOrder; // Display order in UI

  late bool isEnabled; // Is this task active in the checklist

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}
