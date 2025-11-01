import 'dart:convert';
import 'package:isar/isar.dart';
import '../../data/models/tasks.dart';

/// Service for updating Tasks from Firebase Remote Config
///
/// This service checks Firebase every 24 hours for task updates and applies them
/// to the Tasks table directly. Updates can include:
/// - Adding new tasks to the library
/// - Updating existing tasks (title, icon, category changes)
/// - Deactivating old tasks (isActive = false)
/// - Version tracking for managing updates
class TasksUpdateService {
  final Isar _isar;
  DateTime? _lastUpdateCheck;
  static const Duration _updateCheckInterval = Duration(hours: 24);

  TasksUpdateService(this._isar);

  /// Check if it's time to check for updates
  bool get shouldCheckForUpdates {
    if (_lastUpdateCheck == null) return true;
    return DateTime.now().difference(_lastUpdateCheck!) > _updateCheckInterval;
  }

  /// Check Firebase for task updates and apply them
  /// This is the main method that should be called periodically
  Future<void> checkForUpdates() async {
    if (!shouldCheckForUpdates) {
      print('⏭️  [TasksUpdate] Skipping update check (last check: $_lastUpdateCheck)');
      return;
    }

    print('🔍 [TasksUpdate] Checking for task updates from Firebase...');
    _lastUpdateCheck = DateTime.now();

    try {
      // STUB: Fetch remote version from Firebase Remote Config
      final remoteVersion = await _fetchRemoteVersion();
      final currentVersion = await _getCurrentVersion();

      print('📊 [TasksUpdate] Current version: $currentVersion, Remote version: $remoteVersion');

      if (remoteVersion > currentVersion) {
        print('🆕 [TasksUpdate] New version available. Fetching updates...');

        // STUB: Fetch tasks JSON from Firebase
        final tasksJson = await _fetchTasksJson();

        // Apply updates to database
        await _applyUpdates(tasksJson, remoteVersion);

        print('✅ [TasksUpdate] Updates applied successfully!');
      } else {
        print('✅ [TasksUpdate] Tasks are up to date!');
      }
    } catch (e) {
      print('❌ [TasksUpdate] Failed to check for updates: $e');
      // Don't throw - updates are not critical, app should continue working
    }
  }

  /// STUB: Fetch current version from database
  /// In production, this would check the highest version number in Tasks table
  Future<int> _getCurrentVersion() async {
    final tasks = await _isar.tasks
        .filter()
        .isCustomEqualTo(false)
        .sortByVersionDesc()
        .findAll();

    if (tasks.isEmpty) return 1;
    return tasks.first.version;
  }

  /// STUB: Fetch remote version from Firebase Remote Config
  /// User will implement the actual Firebase integration
  ///
  /// Example implementation:
  /// ```dart
  /// final remoteConfig = FirebaseRemoteConfig.instance;
  /// await remoteConfig.fetchAndActivate();
  /// return remoteConfig.getInt('tasks_version');
  /// ```
  Future<int> _fetchRemoteVersion() async {
    // STUB: Return current version (no updates available yet)
    // User will replace this with actual Firebase Remote Config fetch
    print('⚠️  [TasksUpdate] Using STUB _fetchRemoteVersion() - no Firebase integration yet');
    return 1;
  }

  /// STUB: Fetch tasks JSON from Firebase Remote Config
  /// User will implement the actual Firebase integration
  ///
  /// Expected JSON format:
  /// ```json
  /// {
  ///   "version": 2,
  ///   "tasks": [
  ///     {
  ///       "libraryId": "brush-teeth",
  ///       "title": "Чистить зубы",
  ///       "icon": "🪥",
  ///       "category": "hygiene",
  ///       "isActive": true
  ///     },
  ///     {
  ///       "libraryId": "new-task",
  ///       "title": "New Task",
  ///       "icon": "✨",
  ///       "category": "other",
  ///       "isActive": true
  ///     }
  ///   ]
  /// }
  /// ```
  ///
  /// Example implementation:
  /// ```dart
  /// final remoteConfig = FirebaseRemoteConfig.instance;
  /// return remoteConfig.getString('tasks_library');
  /// ```
  Future<String> _fetchTasksJson() async {
    // STUB: Return empty tasks list
    // User will replace this with actual Firebase Remote Config fetch
    print('⚠️  [TasksUpdate] Using STUB _fetchTasksJson() - no Firebase integration yet');
    return json.encode({
      'version': 1,
      'tasks': []
    });
  }

  /// Apply task updates to the database
  /// This method:
  /// - Updates existing tasks if they have changed
  /// - Adds new tasks from the update
  /// - Does NOT delete tasks (only deactivates via isActive flag)
  Future<void> _applyUpdates(String tasksJson, int newVersion) async {
    final data = json.decode(tasksJson) as Map<String, dynamic>;
    final tasksList = data['tasks'] as List;

    print('📝 [TasksUpdate] Applying ${tasksList.length} task updates...');

    await _isar.writeTxn(() async {
      for (final taskData in tasksList) {
        final libraryId = taskData['libraryId'] as String;

        // Check if task already exists
        final existing = await _isar.tasks
            .filter()
            .libraryIdEqualTo(libraryId)
            .findFirst();

        if (existing != null) {
          // Update existing task
          existing
            ..title = taskData['title'] as String
            ..icon = taskData['icon'] as String
            ..category = taskData['category'] as String?
            ..isActive = taskData['isActive'] as bool
            ..version = newVersion
            ..modifiedAt = DateTime.now();

          await _isar.tasks.put(existing);
          print('  ✏️  [TasksUpdate] Updated: ${existing.title} (${existing.icon})');
        } else {
          // Add new task
          final newTask = Tasks()
            ..libraryId = libraryId
            ..title = taskData['title'] as String
            ..icon = taskData['icon'] as String
            ..category = taskData['category'] as String?
            ..isActive = taskData['isActive'] as bool
            ..version = newVersion
            ..isCustom = false
            ..createdAt = DateTime.now()
            ..modifiedAt = DateTime.now();

          await _isar.tasks.put(newTask);
          print('  ➕ [TasksUpdate] Added: ${newTask.title} (${newTask.icon})');
        }
      }
    });

    print('✅ [TasksUpdate] Applied ${tasksList.length} updates to database');
  }

  /// Force check for updates (ignore 24h interval)
  /// Useful for testing or manual refresh
  Future<void> forceCheckForUpdates() async {
    _lastUpdateCheck = null;
    await checkForUpdates();
  }
}
