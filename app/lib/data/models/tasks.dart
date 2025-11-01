import 'package:isar/isar.dart';

part 'tasks.g.dart';

/// Tasks model - represents a task/chore/habit
@collection
class Tasks {
  Id taskId = Isar.autoIncrement; // Primary key, auto-increment

  @Index(unique: true)
  String? libraryId; // Link to TaskLibrary ID (e.g., "brush-teeth")

  late String title; // Task title (e.g., "Brush teeth", "Walk the dog")

  late String icon; // Icon emoji (e.g., "🪥", "🐕", "📚")

  @Index()
  String? category; // hygiene, chores, learning, pets, health

  late bool isCustom; // User-created or from library

  late int version; // Version number for tracking updates from Firebase

  late bool isActive; // Can be deactivated without deletion

  late DateTime createdAt;

  late DateTime modifiedAt;

  String? cloudKitRecordId; // For CloudKit sync
}
