import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'step1_family_members_screen.dart';
import 'step2_choose_tasks_screen.dart';
import 'step3_set_schedule_screen.dart';
import '../../core/providers/isar_provider.dart';
import '../../data/models/users.dart';
import '../../data/models/tasks.dart';
import '../../data/models/user_tasks.dart';
import '../../data/models/task_completions.dart';

/// Edit flow screen - for editing existing checklist data
/// Similar to OnboardingFlowScreen but loads existing data from database
class EditFlowScreen extends ConsumerStatefulWidget {
  final int checklistId;
  final int initialStep; // 1=members, 2=tasks, 3=schedule

  const EditFlowScreen({
    super.key,
    required this.checklistId,
    this.initialStep = 1,
  });

  @override
  ConsumerState<EditFlowScreen> createState() => _EditFlowScreenState();
}

class _EditFlowScreenState extends ConsumerState<EditFlowScreen> {
  late final PageController _pageController;
  late int _currentPage;

  // Shared editing data
  List<FamilyMember> _members = [];
  Map<String, List<Task>> _tasksByMember = {}; // memberId -> [tasks]
  Map<String, Map<String, List<int>>> _scheduleByMember = {}; // memberId -> {taskId -> [weekdays]}

  // Mapping between temp IDs (FamilyMember.id) and database IDs (Users.userId)
  Map<String, int> _memberIdToUserId = {};
  Map<int, String> _userIdToMemberId = {};

  // Step 2 state
  int _currentMemberIndex = 0;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialStep - 1; // Convert to 0-indexed
    _pageController = PageController(initialPage: _currentPage);
    _loadExistingData();
  }

  Future<void> _loadExistingData() async {
    try {
      final isar = await ref.read(isarProvider.future);

      // Load Users for this checklist
      final users = await isar.users.where().sortBySortOrder().findAll();

      // Load UserTasks for this checklist
      final userTasks = await isar.userTasks
          .filter()
          .checklistIdEqualTo(widget.checklistId)
          .findAll();

      // Convert Users to FamilyMember objects
      for (var i = 0; i < users.length; i++) {
        final user = users[i];
        final memberId = 'member_${user.userId}';

        final member = FamilyMember(
          id: memberId,
          name: user.name,
          role: user.relation == 'parent' ? 'parent' : 'kid',
          avatar: user.avatarEmoji ?? '👤', // Load avatar from database
        );

        _members.add(member);
        _memberIdToUserId[memberId] = user.userId;
        _userIdToMemberId[user.userId] = memberId;
        _tasksByMember[memberId] = [];
        _scheduleByMember[memberId] = {};
      }

      // Load Tasks and build tasksByMember and scheduleByMember
      for (final userTask in userTasks) {
        final userId = userTask.userId;
        final memberId = _userIdToMemberId[userId];
        if (memberId == null) continue;

        // Load Task
        final task = await isar.tasks.get(userTask.taskId);
        if (task == null) continue;

        final taskObj = Task(
          id: task.libraryId ?? 'task_${task.taskId}', // Use libraryId if available for consistency with Step 2
          icon: task.icon,
          name: task.title,
          goal: '', // Not stored in DB
          category: task.category ?? 'other',
          frequency: userTask.frequency,
        );

        _tasksByMember[memberId]!.add(taskObj);

        // Parse frequency string to weekday indices
        // Database: "1,2,3,4,5" = Mon-Fri (ISO 8601: 1=Mon, 7=Sun)
        // UI: [1,2,3,4,5] = Mon-Fri (0=Sun, 1=Mon, ..., 6=Sat)
        final weekdays = userTask.frequency
            .split(',')
            .map((s) => int.tryParse(s.trim()))
            .where((d) => d != null)
            .map((d) {
          if (d == 7) return 0; // Sunday: DB 7 -> UI 0
          return d!; // Mon-Sat: DB 1-6 -> UI 1-6
        }).toList();

        _scheduleByMember[memberId]![taskObj.id] = weekdays;
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // Step 1 -> Step 2
  void _onStep1Continue(List<FamilyMember> members) {
    setState(() {
      _members = members;
      // Initialize empty task lists for new members
      for (final member in members) {
        if (!_tasksByMember.containsKey(member.id)) {
          _tasksByMember[member.id] = [];
        }
      }
      _currentMemberIndex = 0;
    });
    _goToNextPage();
  }

  // Step 2 -> either next member or Step 3
  void _onStep2Continue(String memberId, List<Task> selectedTasks) {
    setState(() {
      _tasksByMember[memberId] = selectedTasks;
      _currentMemberIndex++;
    });

    // Check if we have more members
    if (_currentMemberIndex < _members.length) {
      // Stay on Step 2, just update state to show next member
      setState(() {});
    } else {
      // All members done, go to Step 3
      // Initialize schedule for new tasks
      for (final member in _members) {
        if (!_scheduleByMember.containsKey(member.id)) {
          _scheduleByMember[member.id] = {};
        }
        for (final task in _tasksByMember[member.id]!) {
          if (!_scheduleByMember[member.id]!.containsKey(task.id)) {
            _scheduleByMember[member.id]![task.id] = [0, 1, 2, 3, 4, 5, 6]; // All days
          }
        }
      }
      _goToNextPage();
    }
  }

  // Step 3 -> Save and return to Weekly Board
  Future<void> _saveChanges() async {
    try {
      final isar = await ref.read(isarProvider.future);

      // CRITICAL: Load all existing tasks BEFORE transaction to avoid "Unique index violated"
      print('[EditFlow] Loading existing tasks from database...');
      final allExistingTasks = <Tasks>[];
      final count = await isar.tasks.count();
      print('[EditFlow] Found $count tasks in database');

      for (var i = 1; i <= count + 100; i++) {
        final task = await isar.tasks.get(i);
        if (task != null) {
          allExistingTasks.add(task);
        }
      }
      print('[EditFlow] Loaded ${allExistingTasks.length} existing tasks');

      await isar.writeTxn(() async {
        // 1. Update/Create Users
        final userIdMap = <String, int>{}; // memberId -> userId
        final availableColors = ['#9B59D0', '#7CB342', '#E57373', '#42A5F5', '#FFA726', '#26A69A'];

        for (var i = 0; i < _members.length; i++) {
          final member = _members[i];
          final existingUserId = _memberIdToUserId[member.id];

          if (existingUserId != null) {
            // Update existing user
            final user = await isar.users.get(existingUserId);
            if (user != null) {
              user.name = member.name.isEmpty ? 'Member ${i + 1}' : member.name;
              user.avatarEmoji = member.avatar;
              user.relation = member.role == 'parent' ? 'parent' : 'child';
              user.sortOrder = i;
              user.modifiedAt = DateTime.now();
              await isar.users.put(user);
              userIdMap[member.id] = user.userId;
            }
          } else {
            // Create new user
            final user = Users()
              ..name = member.name.isEmpty ? 'Member ${i + 1}' : member.name
              ..avatarEmoji = member.avatar
              ..colorHex = availableColors[i % availableColors.length]
              ..relation = member.role == 'parent' ? 'parent' : 'child'
              ..sortOrder = i
              ..createdAt = DateTime.now()
              ..modifiedAt = DateTime.now();

            await isar.users.put(user);
            userIdMap[member.id] = user.userId!;
            _memberIdToUserId[member.id] = user.userId!;
          }
        }

        // 2. Delete UserTasks and TaskCompletions for removed members
        final currentUserIds = userIdMap.values.toSet();
        final allUserTasks = await isar.userTasks
            .filter()
            .checklistIdEqualTo(widget.checklistId)
            .findAll();

        for (final userTask in allUserTasks) {
          if (!currentUserIds.contains(userTask.userId)) {
            // Delete task completions
            final completions = await isar.taskCompletions
                .filter()
                .userIdEqualTo(userTask.userId)
                .taskIdEqualTo(userTask.taskId)
                .checklistIdEqualTo(widget.checklistId)
                .findAll();

            for (final completion in completions) {
              await isar.taskCompletions.delete(completion.id);
            }

            // Delete user task
            await isar.userTasks.delete(userTask.id);
          }
        }

        // 3. Update/Create Tasks and UserTasks
        for (final member in _members) {
          final tasks = _tasksByMember[member.id] ?? [];
          final userId = userIdMap[member.id]!;

          // Get existing UserTasks for this user
          final existingUserTasks = await isar.userTasks
              .filter()
              .userIdEqualTo(userId)
              .checklistIdEqualTo(widget.checklistId)
              .findAll();

          // Track which tasks are still assigned
          final currentTaskIds = <int>{};

          for (var taskIndex = 0; taskIndex < tasks.length; taskIndex++) {
            final taskObj = tasks[taskIndex];

            // Extract taskId from temp id (format: "task_123")
            int? taskId;
            if (taskObj.id.startsWith('task_')) {
              taskId = int.tryParse(taskObj.id.substring(5));
            }

            // Create or update Task
            if (taskId != null) {
              // Existing task by ID
              final task = await isar.tasks.get(taskId);
              if (task != null) {
                task.title = taskObj.name;
                task.icon = taskObj.icon;
                task.category = taskObj.category;
                task.modifiedAt = DateTime.now();
                await isar.tasks.put(task);
                currentTaskIds.add(taskId);
              }
            } else {
              // New task - check if it exists by libraryId to avoid "Unique index violated"
              final existingTask = allExistingTasks.cast<Tasks?>().firstWhere(
                (t) => t?.libraryId == taskObj.id,
                orElse: () => null,
              );

              if (existingTask != null) {
                // Task already exists, use it
                taskId = existingTask.taskId!;
                currentTaskIds.add(taskId);
                print('[EditFlow] Found existing task by libraryId: ${existingTask.title} (taskId: $taskId)');
              } else {
                // Create completely new task
                final task = Tasks()
                  ..title = taskObj.name
                  ..icon = taskObj.icon
                  ..category = taskObj.category
                  ..libraryId = taskObj.id  // Link to TaskLibrary
                  ..version = 1
                  ..isActive = true
                  ..isCustom = false
                  ..createdAt = DateTime.now()
                  ..modifiedAt = DateTime.now();

                await isar.tasks.put(task);
                taskId = task.taskId!;
                currentTaskIds.add(taskId);
                print('[EditFlow] Created new task: ${task.title} (taskId: $taskId)');
              }
            }

            // Get schedule for this task
            final weekdays = _scheduleByMember[member.id]?[taskObj.id] ?? [];

            // Convert weekday indices (0-6: Sun-Sat) to frequency string (1-7: Mon-Sun)
            final dbWeekdays = weekdays.map((day) {
              if (day == 0) return 7; // Sunday
              return day; // Mon-Sat stay the same (1-6)
            }).toList()..sort();

            final frequency = dbWeekdays.join(',');

            // Find or create UserTask
            final existingUserTask = existingUserTasks.firstWhere(
              (ut) => ut.taskId == taskId,
              orElse: () => UserTasks()
                ..userId = userId
                ..taskId = taskId!
                ..checklistId = widget.checklistId
                ..isEnabled = true
                ..createdAt = DateTime.now(),
            );

            existingUserTask.frequency = frequency;
            existingUserTask.sortOrder = taskIndex;
            existingUserTask.modifiedAt = DateTime.now();

            await isar.userTasks.put(existingUserTask);
          }

          // Delete UserTasks that are no longer assigned
          for (final userTask in existingUserTasks) {
            if (!currentTaskIds.contains(userTask.taskId)) {
              // Delete task completions
              final completions = await isar.taskCompletions
                  .filter()
                  .userIdEqualTo(userId)
                  .taskIdEqualTo(userTask.taskId)
                  .checklistIdEqualTo(widget.checklistId)
                  .findAll();

              for (final completion in completions) {
                await isar.taskCompletions.delete(completion.id);
              }

              // Delete user task
              await isar.userTasks.delete(userTask.id);
            }
          }
        }
      });

      // Navigate to Weekly Board
      if (mounted) {
        context.go('/checklist/${widget.checklistId}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving changes: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF5F5F7),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // PageView with 3 screens (no welcome screen in edit mode)
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Screen 1: Family Members
              Step1FamilyMembersScreen(
                onContinue: _onStep1Continue,
                initialMembers: _members,
                checklistId: widget.checklistId,
              ),
              // Screen 2: Choose Tasks (multi-member flow)
              _currentPage == 1 && _members.isNotEmpty && _currentMemberIndex < _members.length
                  ? Builder(
                      builder: (context) {
                        final member = _members[_currentMemberIndex];
                        final tasks = _tasksByMember[member.id] ?? [];
                        print('[EditFlow] Building Step2 for member: ${member.name} (${member.id})');
                        print('[EditFlow] Passing ${tasks.length} initialSelectedTasks: ${tasks.map((t) => t.name).join(", ")}');
                        return Step2ChooseTasksScreen(
                          member: member,
                          currentIndex: _currentMemberIndex,
                          totalMembers: _members.length,
                          allMembers: _members,
                          onContinue: _onStep2Continue,
                          initialSelectedTasks: tasks,
                          checklistId: widget.checklistId,
                        );
                      },
                    )
                  : const SizedBox(),
              // Screen 3: Set Schedule
              Step3SetScheduleScreen(
                members: _members,
                tasksByMember: _tasksByMember,
                scheduleByMember: _scheduleByMember,
                onScheduleUpdate: (memberId, taskId, weekdays) {
                  setState(() {
                    _scheduleByMember[memberId]![taskId] = weekdays;
                  });
                },
                onCreateChecklist: _saveChanges,
                isEditMode: true,
                checklistId: widget.checklistId,
              ),
            ],
          ),
          // Header with close button (left)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 20,
            child: SizedBox(
              height: 32,
              child: GestureDetector(
                onTap: () {
                  // Navigate back to weekly board without saving
                  context.go('/checklist/${widget.checklistId}');
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
            ),
          ),
          // Progress indicators (center of screen)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 32,
              child: Center(
                child: _buildProgressIndicators(),
              ),
            ),
          ),
          // Step indicator (right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 20,
            child: SizedBox(
              height: 32,
              child: Align(
                alignment: Alignment.center,
                child: _buildStepIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0A7FCC) : const Color(0xFFC7C7CC),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Step ${_currentPage + 1}/3',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF8E8E93),
        ),
      ),
    );
  }
}
