import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/user_tasks.dart';

part 'user_tasks_repository.g.dart';

/// Repository for user tasks (task assignments) operations
@riverpod
UserTasksRepository userTasksRepository(UserTasksRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return UserTasksRepository(isar);
}

class UserTasksRepository {
  final Isar _isar;

  UserTasksRepository(this._isar);

  /// Get all user tasks for a checklist
  Future<List<UserTasks>> getUserTasksByChecklistId(int checklistId) async {
    return await _isar.userTasks
        .filter()
        .checklistIdEqualTo(checklistId)
        .sortBySortOrder()
        .findAll();
  }

  /// Get user tasks for a specific user in a checklist
  Future<List<UserTasks>> getUserTasksByUserAndChecklist(
    int userId,
    int checklistId,
  ) async {
    return await _isar.userTasks
        .filter()
        .userIdEqualTo(userId)
        .checklistIdEqualTo(checklistId)
        .isEnabledEqualTo(true)
        .sortBySortOrder()
        .findAll();
  }

  /// Get user task by user and task ID
  Future<UserTasks?> getUserTask(int userId, int taskId) async {
    return await _isar.userTasks
        .filter()
        .userIdEqualTo(userId)
        .taskIdEqualTo(taskId)
        .findFirst();
  }

  /// Create or update user task
  Future<void> saveUserTask(UserTasks userTask) async {
    userTask.modifiedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.userTasks.put(userTask);
    });
  }

  /// Delete user task
  Future<void> deleteUserTask(int userId, int taskId) async {
    final userTask = await getUserTask(userId, taskId);
    if (userTask == null) return;

    await _isar.writeTxn(() async {
      await _isar.userTasks.delete(userTask.id);
    });
  }

  /// Delete all user tasks for a checklist
  Future<void> deleteUserTasksByChecklistId(int checklistId) async {
    final userTasks = await getUserTasksByChecklistId(checklistId);

    await _isar.writeTxn(() async {
      for (var userTask in userTasks) {
        await _isar.userTasks.delete(userTask.id);
      }
    });
  }

  /// Watch user tasks for a checklist (stream)
  Stream<List<UserTasks>> watchUserTasksByChecklistId(int checklistId) {
    return _isar.userTasks
        .filter()
        .checklistIdEqualTo(checklistId)
        .sortBySortOrder()
        .watch(fireImmediately: true);
  }
}
