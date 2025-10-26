import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/tasks.dart';

part 'tasks_repository.g.dart';

/// Repository for tasks operations
@riverpod
TasksRepository tasksRepository(TasksRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return TasksRepository(isar);
}

class TasksRepository {
  final Isar _isar;

  TasksRepository(this._isar);

  /// Get all tasks
  Future<List<Tasks>> getAllTasks() async {
    return await _isar.tasks.where().findAll();
  }

  /// Get task by ID
  Future<Tasks?> getTaskById(int taskId) async {
    return await _isar.tasks.get(taskId);
  }

  /// Get tasks by category
  Future<List<Tasks>> getTasksByCategory(String category) async {
    return await _isar.tasks.filter().categoryEqualTo(category).findAll();
  }

  /// Get library tasks (predefined)
  Future<List<Tasks>> getLibraryTasks() async {
    return await _isar.tasks.filter().isCustomEqualTo(false).findAll();
  }

  /// Get custom tasks (user-created)
  Future<List<Tasks>> getCustomTasks() async {
    return await _isar.tasks.filter().isCustomEqualTo(true).findAll();
  }

  /// Create or update task
  Future<void> saveTask(Tasks task) async {
    task.modifiedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.tasks.put(task);
    });
  }

  /// Delete task
  Future<void> deleteTask(int taskId) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.delete(taskId);
    });
  }

  /// Watch all tasks (stream for reactive updates)
  Stream<List<Tasks>> watchTasks() {
    return _isar.tasks.where().watch(fireImmediately: true);
  }

  /// Watch library tasks
  Stream<List<Tasks>> watchLibraryTasks() {
    return _isar.tasks
        .filter()
        .isCustomEqualTo(false)
        .watch(fireImmediately: true);
  }
}
