import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/users.dart';
import '../../data/models/checklists.dart';
import '../../data/models/tasks.dart';
import '../../data/models/user_tasks.dart';
import '../../data/models/task_completions.dart';
import '../../data/models/achievements.dart';
import '../../data/models/settings.dart';

part 'isar_provider.g.dart';

/// Isar database provider
@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [
      UsersSchema,
      ChecklistsSchema,
      TasksSchema,
      UserTasksSchema,
      TaskCompletionsSchema,
      AchievementsSchema,
      SettingsSchema,
    ],
    directory: dir.path,
    name: 'family_chart',
  );

  // Keep database open for the lifetime of the app
  ref.onDispose(() {
    isar.close();
  });

  return isar;
}
