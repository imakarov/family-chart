import 'package:isar/isar.dart';

part 'task_completions.g.dart';

/// TaskCompletions model - tracks task completion history by day/week
@collection
class TaskCompletions {
  Id id = Isar.autoIncrement; // Auto-increment ID

  @Index()
  late int userId; // FK to Users

  @Index()
  late int taskId; // FK to Tasks

  @Index()
  late int weekNumber; // Week number in year (1-53, ISO 8601)

  @Index()
  late int weekYear; // Year (2025, 2026)

  @Index()
  late int dayOfWeek; // Day of week: 1=Mon, 7=Sun (ISO 8601)

  @Index()
  late int checklistId; // FK to Checklists (for filtering)

  late DateTime completionDate; // Full date of completion

  late bool isCompleted; // Is task completed

  DateTime? completedAt; // Exact timestamp of completion

  int? completedBy; // userId who marked it

  @Enumerated(EnumType.name)
  late TaskCompletionSource source; // How was it marked

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}

/// How the task completion was created
enum TaskCompletionSource {
  manual, // Marked manually in app
  ocr, // Recognized from photo (OCR)
  sync, // Synced from another device
}
