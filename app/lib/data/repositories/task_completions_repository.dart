import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/providers/isar_provider.dart';
import '../models/task_completions.dart';

part 'task_completions_repository.g.dart';

/// Repository for task completions operations
@riverpod
TaskCompletionsRepository taskCompletionsRepository(
    TaskCompletionsRepositoryRef ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return TaskCompletionsRepository(isar);
}

class TaskCompletionsRepository {
  final Isar _isar;

  TaskCompletionsRepository(this._isar);

  /// Get all completions for a week
  Future<List<TaskCompletions>> getCompletionsByWeek(
    int weekNumber,
    int weekYear,
    int checklistId,
  ) async {
    return await _isar.taskCompletions
        .filter()
        .weekNumberEqualTo(weekNumber)
        .weekYearEqualTo(weekYear)
        .checklistIdEqualTo(checklistId)
        .findAll();
  }

  /// Get completions for a specific day
  Future<List<TaskCompletions>> getCompletionsByDay(
    int weekNumber,
    int weekYear,
    int dayOfWeek,
    int checklistId,
  ) async {
    return await _isar.taskCompletions
        .filter()
        .weekNumberEqualTo(weekNumber)
        .weekYearEqualTo(weekYear)
        .dayOfWeekEqualTo(dayOfWeek)
        .checklistIdEqualTo(checklistId)
        .findAll();
  }

  /// Get completion for a specific user task on a specific day
  Future<TaskCompletions?> getCompletion(
    int userId,
    int taskId,
    int weekNumber,
    int weekYear,
    int dayOfWeek,
  ) async {
    return await _isar.taskCompletions
        .filter()
        .userIdEqualTo(userId)
        .taskIdEqualTo(taskId)
        .weekNumberEqualTo(weekNumber)
        .weekYearEqualTo(weekYear)
        .dayOfWeekEqualTo(dayOfWeek)
        .findFirst();
  }

  /// Get all completions for a user in a date range
  Future<List<TaskCompletions>> getCompletionsByUserAndDateRange(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _isar.taskCompletions
        .filter()
        .userIdEqualTo(userId)
        .completionDateBetween(startDate, endDate)
        .sortByCompletionDate()
        .findAll();
  }

  /// Create or update task completion
  Future<void> saveCompletion(TaskCompletions completion) async {
    completion.modifiedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.taskCompletions.put(completion);
    });
  }

  /// Toggle completion status
  Future<void> toggleCompletion(
    int userId,
    int taskId,
    int weekNumber,
    int weekYear,
    int dayOfWeek,
    int checklistId,
    DateTime completionDate,
  ) async {
    final existing = await getCompletion(
      userId,
      taskId,
      weekNumber,
      weekYear,
      dayOfWeek,
    );

    final now = DateTime.now();

    if (existing != null) {
      // Toggle existing completion
      existing.isCompleted = !existing.isCompleted;
      existing.completedAt = existing.isCompleted ? now : null;
      existing.modifiedAt = now;

      await _isar.writeTxn(() async {
        await _isar.taskCompletions.put(existing);
      });
    } else {
      // Create new completion - use the provided completionDate for the day being toggled
      final completion = TaskCompletions()
        ..userId = userId
        ..taskId = taskId
        ..weekNumber = weekNumber
        ..weekYear = weekYear
        ..dayOfWeek = dayOfWeek
        ..checklistId = checklistId
        ..completionDate = completionDate
        ..isCompleted = true
        ..completedAt = now
        ..source = TaskCompletionSource.manual
        ..modifiedAt = now;

      await _isar.writeTxn(() async {
        await _isar.taskCompletions.put(completion);
      });
    }
  }

  /// Watch completions for a week (stream)
  Stream<List<TaskCompletions>> watchCompletionsByWeek(
    int weekNumber,
    int weekYear,
    int checklistId,
  ) {
    return _isar.taskCompletions
        .filter()
        .weekNumberEqualTo(weekNumber)
        .weekYearEqualTo(weekYear)
        .checklistIdEqualTo(checklistId)
        .watch(fireImmediately: true);
  }
}
