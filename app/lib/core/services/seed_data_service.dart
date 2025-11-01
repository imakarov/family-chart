import 'package:isar/isar.dart';
import '../../data/models/users.dart';
import '../../data/models/checklists.dart';
import '../../data/models/tasks.dart';
import '../../data/models/user_tasks.dart';
import '../../data/models/task_completions.dart';
import '../utils/date_utils.dart' as app_date_utils;

/// Service to populate demo data on first launch
class SeedDataService {
  final Isar _isar;

  SeedDataService(this._isar);

  /// Check if demo data already exists
  Future<bool> isDemoDataSeeded() async {
    final checklistCount = await _isar.checklists.count();
    return checklistCount > 0;
  }

  /// Seed demo data from HTML prototype
  Future<void> seedDemoData() async {
    if (await isDemoDataSeeded()) {
      print('Demo data already exists, skipping seed');
      return;
    }

    print('Seeding demo data...');

    await _isar.writeTxn(() async {
      // 1. Create Checklist
      final checklist = Checklists()
        ..name = 'Семейная рутина'
        ..isRepeating = true
        ..isArchived = false
        ..createdAt = DateTime.now()
        ..modifiedAt = DateTime.now();

      await _isar.checklists.put(checklist);
      final checklistId = checklist.checklistId;

      // 2. Create Users (Members)
      final users = [
        Users()
          ..name = 'Мама'
          ..colorHex = '#9B59D0'
          ..relation = 'parent'
          ..sortOrder = 0
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),
        Users()
          ..name = 'Папа'
          ..colorHex = '#7CB342'
          ..relation = 'parent'
          ..sortOrder = 1
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),
        Users()
          ..name = 'Дочь'
          ..colorHex = '#E57373'
          ..relation = 'child'
          ..sortOrder = 2
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),
        Users()
          ..name = 'Сын'
          ..colorHex = '#42A5F5'
          ..relation = 'child'
          ..sortOrder = 3
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),
      ];

      for (var user in users) {
        await _isar.users.put(user);
      }

      final mamaId = users[0].userId;
      final papaId = users[1].userId;
      final dochId = users[2].userId;
      final synId = users[3].userId;

      // 3. Load Tasks from database (already seeded by TasksSeedingService)
      // We find existing tasks by title and icon
      print('[SeedData] Loading existing tasks from database...');
      final allDbTasks = await _isar.tasks.where().findAll();
      print('[SeedData] Found ${allDbTasks.length} tasks in database');

      final tasks = <Tasks>[];
      final tasksToCreate = <Map<String, String>>[];

      // Task specs for demo data
      final taskSpecs = [
        {'title': 'Спорт', 'icon': '🏃'},
        {'title': 'Чтение', 'icon': '📚'},
        {'title': 'Готовка обеда', 'icon': '🍳'},
        {'title': 'Йога', 'icon': '🧘'},
        {'title': 'Чтение', 'icon': '📖'},
        {'title': 'Футбол', 'icon': '⚽'},
        {'title': 'Умывание и зубы', 'icon': '🪥'},
        {'title': 'LogicLike', 'icon': '🧠'},
        {'title': 'Убирать за котом', 'icon': '🐱'},
        {'title': 'Учёба', 'icon': '🎓'},
        {'title': 'Спорт', 'icon': '🏃‍♀️'},
      ];

      // Find existing tasks or mark for creation
      for (final spec in taskSpecs) {
        Tasks? existing;
        try {
          existing = allDbTasks.firstWhere(
            (t) => t.title == spec['title'] && t.icon == spec['icon'],
          );
        } catch (e) {
          existing = null;
        }

        if (existing != null) {
          tasks.add(existing);
          print('[SeedData] Found existing: ${spec['title']} ${spec['icon']}');
        } else {
          tasksToCreate.add(spec);
          print('[SeedData] Will create: ${spec['title']} ${spec['icon']}');
        }
      }

      // 3a. Create missing tasks INSIDE transaction
      for (final spec in tasksToCreate) {
        final newTask = Tasks()
          ..title = spec['title']!
          ..icon = spec['icon']!
          ..category = 'other'
          ..libraryId = null
          ..version = 1
          ..isActive = true
          ..isCustom = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now();

        await _isar.tasks.put(newTask);
        tasks.add(newTask);
        print('[SeedData] Created custom task: ${spec['title']} ${spec['icon']} (id: ${newTask.taskId})');
      }

      // 4. Create UserTasks (Assignments)
      final userTasks = [
        // Папа: Спорт (ежедневно)
        UserTasks()
          ..userId = papaId
          ..taskId = tasks[0].taskId
          ..checklistId = checklistId
          ..frequency = '1,2,3,4,5,6,7'
          ..sortOrder = 0
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Папа: Чтение (ежедневно)
        UserTasks()
          ..userId = papaId
          ..taskId = tasks[1].taskId
          ..checklistId = checklistId
          ..frequency = '1,2,3,4,5,6,7'
          ..sortOrder = 1
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Папа: Готовка обеда (Пн, Ср, Пт)
        UserTasks()
          ..userId = papaId
          ..taskId = tasks[2].taskId
          ..checklistId = checklistId
          ..frequency = '1,3,5'
          ..sortOrder = 2
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Мама: Готовка обеда (Вт, Чт)
        UserTasks()
          ..userId = mamaId
          ..taskId = tasks[2].taskId
          ..checklistId = checklistId
          ..frequency = '2,4'
          ..sortOrder = 0
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Мама: Йога (Ср, Сб)
        UserTasks()
          ..userId = mamaId
          ..taskId = tasks[3].taskId
          ..checklistId = checklistId
          ..frequency = '3,6'
          ..sortOrder = 1
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Сын: Чтение (Пн-Пт)
        UserTasks()
          ..userId = synId
          ..taskId = tasks[4].taskId
          ..checklistId = checklistId
          ..frequency = '1,2,3,4,5'
          ..sortOrder = 0
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Сын: Футбол (Пн, Вт, Чт)
        UserTasks()
          ..userId = synId
          ..taskId = tasks[5].taskId
          ..checklistId = checklistId
          ..frequency = '1,2,4'
          ..sortOrder = 1
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Сын: Умывание и зубы (ежедневно)
        UserTasks()
          ..userId = synId
          ..taskId = tasks[6].taskId
          ..checklistId = checklistId
          ..frequency = '1,2,3,4,5,6,7'
          ..sortOrder = 2
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Сын: LogicLike (Ср, Пт)
        UserTasks()
          ..userId = synId
          ..taskId = tasks[7].taskId
          ..checklistId = checklistId
          ..frequency = '3,5'
          ..sortOrder = 3
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Дочь: Убирать за котом (ежедневно)
        UserTasks()
          ..userId = dochId
          ..taskId = tasks[8].taskId
          ..checklistId = checklistId
          ..frequency = '1,2,3,4,5,6,7'
          ..sortOrder = 0
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Дочь: Учёба (Пн, Ср, Пт)
        UserTasks()
          ..userId = dochId
          ..taskId = tasks[9].taskId
          ..checklistId = checklistId
          ..frequency = '1,3,5'
          ..sortOrder = 1
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),

        // Дочь: Спорт (Вт, Чт)
        UserTasks()
          ..userId = dochId
          ..taskId = tasks[10].taskId
          ..checklistId = checklistId
          ..frequency = '2,4'
          ..sortOrder = 2
          ..isEnabled = true
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now(),
      ];

      for (var userTask in userTasks) {
        await _isar.userTasks.put(userTask);
      }

      // 5. Create TaskCompletions (demo completions for current week)
      final now = DateTime.now();
      final weekNumber = app_date_utils.DateUtils.getWeekNumber(now);
      final weekYear = app_date_utils.DateUtils.getWeekYear(now);
      final weekStart = app_date_utils.DateUtils.getWeekStartDate(weekNumber, weekYear);

      // Monday completions
      final mondayDate = weekStart;
      final mondayCompletions = [
        // Сын: Чтение, Футбол, Умывание
        _createCompletion(synId, tasks[4].taskId, checklistId, mondayDate, weekNumber, weekYear, 1, true),
        _createCompletion(synId, tasks[5].taskId, checklistId, mondayDate, weekNumber, weekYear, 1, true),
        _createCompletion(synId, tasks[6].taskId, checklistId, mondayDate, weekNumber, weekYear, 1, true),
        // Дочь: Убирать за котом, Учёба
        _createCompletion(dochId, tasks[8].taskId, checklistId, mondayDate, weekNumber, weekYear, 1, true),
        _createCompletion(dochId, tasks[9].taskId, checklistId, mondayDate, weekNumber, weekYear, 1, true),
      ];

      // Tuesday completions
      final tuesdayDate = weekStart.add(const Duration(days: 1));
      final tuesdayCompletions = [
        // Папа: Спорт, Готовка обеда
        _createCompletion(papaId, tasks[0].taskId, checklistId, tuesdayDate, weekNumber, weekYear, 2, true),
        _createCompletion(papaId, tasks[2].taskId, checklistId, tuesdayDate, weekNumber, weekYear, 2, true),
        // Дочь: Убирать за котом, Спорт
        _createCompletion(dochId, tasks[8].taskId, checklistId, tuesdayDate, weekNumber, weekYear, 2, true),
        _createCompletion(dochId, tasks[10].taskId, checklistId, tuesdayDate, weekNumber, weekYear, 2, true),
      ];

      // Wednesday completions
      final wednesdayDate = weekStart.add(const Duration(days: 2));
      final wednesdayCompletions = [
        // Мама: Йога
        _createCompletion(mamaId, tasks[3].taskId, checklistId, wednesdayDate, weekNumber, weekYear, 3, true),
        // Сын: Чтение, Умывание, LogicLike
        _createCompletion(synId, tasks[4].taskId, checklistId, wednesdayDate, weekNumber, weekYear, 3, true),
        _createCompletion(synId, tasks[6].taskId, checklistId, wednesdayDate, weekNumber, weekYear, 3, true),
        _createCompletion(synId, tasks[7].taskId, checklistId, wednesdayDate, weekNumber, weekYear, 3, true),
        // Дочь: Убирать за котом (не выполнено)
        _createCompletion(dochId, tasks[8].taskId, checklistId, wednesdayDate, weekNumber, weekYear, 3, false),
      ];

      final allCompletions = [...mondayCompletions, ...tuesdayCompletions, ...wednesdayCompletions];
      for (var completion in allCompletions) {
        await _isar.taskCompletions.put(completion);
      }
    });

    print('Demo data seeded successfully!');
  }

  TaskCompletions _createCompletion(
    int userId,
    int taskId,
    int checklistId,
    DateTime date,
    int weekNumber,
    int weekYear,
    int dayOfWeek,
    bool isCompleted,
  ) {
    return TaskCompletions()
      ..userId = userId
      ..taskId = taskId
      ..checklistId = checklistId
      ..weekNumber = weekNumber
      ..weekYear = weekYear
      ..dayOfWeek = dayOfWeek
      ..completionDate = date
      ..isCompleted = isCompleted
      ..completedAt = isCompleted ? date : null
      ..completedBy = isCompleted ? userId : null
      ..source = TaskCompletionSource.manual
      ..modifiedAt = DateTime.now();
  }

  /// Helper method to get existing task from DB or create a new custom task
  Future<Tasks> _getOrCreateTask(String title, String icon) async {
    // Try to find task in database by title and icon
    final existing = await _isar.tasks
        .filter()
        .titleEqualTo(title)
        .iconEqualTo(icon)
        .findFirst();

    if (existing != null) {
      print('[SeedData] Found existing task: $title $icon (id: ${existing.taskId}, libraryId: ${existing.libraryId})');
      return existing;
    }

    // Create new custom task if not found
    // Important: libraryId is null for custom tasks to avoid unique index violation
    final newTask = Tasks()
      ..title = title
      ..icon = icon
      ..category = 'other'
      ..libraryId = null  // Explicitly set to null for custom tasks
      ..version = 1
      ..isActive = true
      ..isCustom = true
      ..createdAt = DateTime.now()
      ..modifiedAt = DateTime.now();

    // Save to database
    await _isar.writeTxn(() async {
      await _isar.tasks.put(newTask);
    });

    print('[SeedData] Created custom task: $title $icon (id: ${newTask.taskId})');
    return newTask;
  }
}
