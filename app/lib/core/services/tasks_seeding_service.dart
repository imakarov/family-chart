import 'package:isar/isar.dart';
import '../../data/models/tasks.dart';
import '../../data/static/task_library.dart';

/// Service for seeding Tasks from TaskLibrary on first launch
class TasksSeedingService {
  final Isar _isar;

  TasksSeedingService(this._isar);

  /// Check if Tasks table needs seeding and seed it if needed
  Future<void> seedTasksIfNeeded() async {
    // Check if there are any non-custom tasks in the database
    final count = await _isar.tasks.filter().isCustomEqualTo(false).count();

    if (count == 0) {
      print('🌱 [TasksSeeding] No library tasks found. Seeding from TaskLibrary...');
      await _seedTasks();
      print('✅ [TasksSeeding] Seeding completed. ${TaskLibrary.all.length} tasks added.');
    } else {
      print('✅ [TasksSeeding] Library tasks already exist in database. Count: $count');
    }
  }

  /// Seed all tasks from TaskLibrary into Tasks table
  Future<void> _seedTasks() async {
    await _isar.writeTxn(() async {
      for (final template in TaskLibrary.all) {
        final task = Tasks()
          ..libraryId = template.id
          ..title = template.name
          ..icon = template.icon
          ..category = template.category
          ..version = 1
          ..isActive = true
          ..isCustom = false
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now();

        await _isar.tasks.put(task);
        print('  📝 [TasksSeeding] Added: ${task.title} (${task.icon}) - libraryId: ${task.libraryId}');
      }
    });
  }

  /// Force reseed - delete all non-custom tasks and reseed from TaskLibrary
  /// Useful for development and testing
  Future<void> forceReseed() async {
    print('🔄 [TasksSeeding] Force reseeding...');

    await _isar.writeTxn(() async {
      // Delete all non-custom tasks
      final libraryTasks = await _isar.tasks
          .filter()
          .isCustomEqualTo(false)
          .findAll();

      for (final task in libraryTasks) {
        await _isar.tasks.delete(task.taskId);
      }

      print('🗑️  [TasksSeeding] Deleted ${libraryTasks.length} existing library tasks');
    });

    // Reseed
    await _seedTasks();
    print('✅ [TasksSeeding] Force reseed completed.');
  }
}
