import 'package:isar/isar.dart';

part 'checklist.g.dart';

/// Checklist model - represents a weekly checklist
@collection
class Checklist {
  Id id = Isar.autoIncrement;

  @Index()
  late String checklistId; // UUID

  late String name;

  @Index()
  late DateTime startDate;

  late DateTime endDate;

  late bool isRepeating;

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}

/// Person model - represents a family member
@collection
class Person {
  Id id = Isar.autoIncrement;

  @Index()
  late String personId; // UUID

  late String name;

  List<byte>? avatarBytes; // Photo as bytes

  late String colorHex; // Color in hex format

  String? relation; // daughter, son, parent, etc.

  String? contactId; // Reference to Contacts app

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId;

  @Index()
  late String checklistId; // Foreign key to Checklist
}

/// Task model - represents a task/chore
@collection
class Task {
  Id id = Isar.autoIncrement;

  @Index()
  late String taskId; // UUID

  late String title;

  late String iconName; // Icon identifier

  @Enumerated(EnumType.name)
  late TaskFrequency frequency;

  String? frequencyData; // JSON for custom frequency

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId;

  @Index()
  late String checklistId; // Foreign key to Checklist

  late String personId; // Foreign key to Person
}

/// Task completion model - tracks individual task completions
@collection
class TaskCompletion {
  Id id = Isar.autoIncrement;

  @Index()
  late String completionId; // UUID

  late String taskId;

  late String personId;

  late String checklistId;

  @Index()
  late DateTime date; // Date of completion (day only)

  late bool isCompleted;

  DateTime? completedAt; // Exact timestamp

  String? completedBy; // Device ID

  late DateTime modifiedAt;

  String? cloudKitRecordId;
}

/// Task frequency enum
enum TaskFrequency {
  daily,
  weekly,
  weekdays, // Mon-Fri
  weekends, // Sat-Sun
  custom, // Custom days (frequencyData contains JSON)
}
