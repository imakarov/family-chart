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

  // Relationships
  final persons = IsarLinks<Person>();
  final tasks = IsarLinks<Task>();

  Checklist({
    required this.checklistId,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.isRepeating = true,
    DateTime? createdAt,
    DateTime? modifiedAt,
    this.cloudKitRecordId,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.modifiedAt = modifiedAt ?? DateTime.now();
  }

  Checklist.empty()
      : checklistId = '',
        name = '',
        startDate = DateTime.now(),
        endDate = DateTime.now(),
        isRepeating = true,
        createdAt = DateTime.now(),
        modifiedAt = DateTime.now();
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

  @Backlink(to: 'persons')
  final checklist = IsarLink<Checklist>();

  Person({
    required this.personId,
    required this.name,
    this.avatarBytes,
    required this.colorHex,
    this.relation,
    this.contactId,
    DateTime? createdAt,
    DateTime? modifiedAt,
    this.cloudKitRecordId,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.modifiedAt = modifiedAt ?? DateTime.now();
  }

  Person.empty()
      : personId = '',
        name = '',
        colorHex = '#007AFF',
        createdAt = DateTime.now(),
        modifiedAt = DateTime.now();
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

  @Backlink(to: 'tasks')
  final checklist = IsarLink<Checklist>();

  final assignedTo = IsarLink<Person>();

  Task({
    required this.taskId,
    required this.title,
    required this.iconName,
    required this.frequency,
    this.frequencyData,
    DateTime? createdAt,
    DateTime? modifiedAt,
    this.cloudKitRecordId,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.modifiedAt = modifiedAt ?? DateTime.now();
  }

  Task.empty()
      : taskId = '',
        title = '',
        iconName = 'checkmark',
        frequency = TaskFrequency.daily,
        createdAt = DateTime.now(),
        modifiedAt = DateTime.now();
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

  TaskCompletion({
    required this.completionId,
    required this.taskId,
    required this.personId,
    required this.checklistId,
    required this.date,
    required this.isCompleted,
    this.completedAt,
    this.completedBy,
    DateTime? modifiedAt,
    this.cloudKitRecordId,
  }) {
    this.modifiedAt = modifiedAt ?? DateTime.now();
  }

  TaskCompletion.empty()
      : completionId = '',
        taskId = '',
        personId = '',
        checklistId = '',
        date = DateTime.now(),
        isCompleted = false,
        modifiedAt = DateTime.now();
}

/// Task frequency enum
enum TaskFrequency {
  daily,
  weekly,
  weekdays, // Mon-Fri
  weekends, // Sat-Sun
  custom, // Custom days (frequencyData contains JSON)
}
