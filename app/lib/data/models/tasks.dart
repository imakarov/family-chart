import 'package:isar/isar.dart';

part 'tasks.g.dart';

/// Tasks model - represents a task/chore/habit
@collection
class Tasks {
  Id taskId = Isar.autoIncrement; // Primary key, auto-increment

  late String title; // Task title (e.g., "Brush teeth", "Walk the dog")

  late String iconName; // Icon identifier (toothbrush, dog, book)

  @Index()
  String? category; // hygiene, chores, learning, pets, health

  late bool isCustom; // User-created or from library

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}
