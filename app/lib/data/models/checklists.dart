import 'package:isar/isar.dart';

part 'checklists.g.dart';

/// Checklists model - represents a weekly checklist template
@collection
class Checklists {
  Id checklistId = Isar.autoIncrement; // Primary key, auto-increment

  late String name; // Checklist name (e.g., "School Week", "Vacation")

  late bool isRepeating; // Repeats every week

  late bool isArchived; // Is archived

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}
