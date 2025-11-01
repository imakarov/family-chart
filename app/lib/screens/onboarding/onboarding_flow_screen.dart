import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'welcome_screen.dart';
import 'step1_family_members_screen.dart';
import 'step2_choose_tasks_screen.dart';
import 'step3_set_schedule_screen.dart';
import '../../core/providers/isar_provider.dart';
import '../../data/models/users.dart';
import '../../data/models/checklists.dart';
import '../../data/models/tasks.dart';
import '../../data/models/user_tasks.dart';

/// Main onboarding flow with PageView navigation and shared state
class OnboardingFlowScreen extends ConsumerStatefulWidget {
  final int initialStep; // 0=welcome, 1=members, 2=tasks, 3=schedule

  const OnboardingFlowScreen({super.key, this.initialStep = 0});

  @override
  ConsumerState<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  late final PageController _pageController;
  late int _currentPage;

  // Shared onboarding data
  List<FamilyMember> _members = [];
  Map<String, List<Task>> _tasksByMember = {}; // memberId -> [tasks]
  Map<String, Map<String, List<int>>> _scheduleByMember = {}; // memberId -> {taskId -> [weekdays]}

  // Step 2 state
  int _currentMemberIndex = 0;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialStep;
    _pageController = PageController(initialPage: widget.initialStep);
    _loadExistingData();
  }

  Future<void> _loadExistingData() async {
    // TODO: Load existing data from database
    // Temporarily disabled - will be implemented in next iteration
    print('Data loading temporarily disabled');

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 3) {
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
      // Initialize empty task lists for each member
      for (final member in members) {
        _tasksByMember[member.id] = [];
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
      // Initialize schedule with all days selected by default (ISO days: 1-7)
      for (final member in _members) {
        _scheduleByMember[member.id] = {};
        for (final task in _tasksByMember[member.id]!) {
          _scheduleByMember[member.id]![task.id] = [1, 2, 3, 4, 5, 6, 7]; // All days (ISO format)
        }
      }
      _goToNextPage();
    }
  }

  // Step 3 -> Complete
  Future<void> _completeOnboarding() async {
    print('Onboarding complete! Saving to database...');

    try {
      final isar = await ref.read(isarProvider.future);
      int? checklistId;

      // CRITICAL: Load all existing tasks BEFORE transaction to avoid query issues
      print('[Onboarding] Loading existing tasks from database...');
      final allExistingTasks = <Tasks>[];

      // Get count first, then load tasks one by one
      final count = await isar.tasks.count();
      print('[Onboarding] Found $count tasks in database');

      for (var i = 1; i <= count + 100; i++) {  // +100 buffer for auto-increment gaps
        final task = await isar.tasks.get(i);
        if (task != null) {
          allExistingTasks.add(task);
        }
      }

      print('[Onboarding] Loaded ${allExistingTasks.length} existing tasks');

      await isar.writeTxn(() async {
        // 1. Create Checklist
        final checklist = Checklists()
          ..name = 'Family Checklist'
          ..isRepeating = true
          ..isArchived = false
          ..createdAt = DateTime.now()
          ..modifiedAt = DateTime.now();

        await isar.checklists.put(checklist);
        checklistId = checklist.checklistId;

        // 2. Create Users from onboarding data
        final userIdMap = <String, int>{}; // onboarding memberId -> db userId
        final availableColors = ['#9B59D0', '#7CB342', '#E57373', '#42A5F5', '#FFA726', '#26A69A'];

        for (var i = 0; i < _members.length; i++) {
          final member = _members[i];
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
        }

        // 3. Create Tasks and UserTasks
        // Track tasks we've already processed in THIS onboarding session
        final processedTasks = <String, Tasks>{};

        for (final member in _members) {
          final tasks = _tasksByMember[member.id] ?? [];
          final userId = userIdMap[member.id]!;

          for (var taskIndex = 0; taskIndex < tasks.length; taskIndex++) {
            final onboardingTask = tasks[taskIndex];

            // Check if we've already processed this task in this onboarding
            Tasks? task = processedTasks[onboardingTask.id];

            if (task == null) {
              // First, try to find existing task in database by libraryId
              task = allExistingTasks.cast<Tasks?>().firstWhere(
                (t) => t?.libraryId == onboardingTask.id,
                orElse: () => null,
              );

              if (task != null) {
                print('[Onboarding] Found existing task: ${task.title} (taskId: ${task.taskId}, libraryId: ${task.libraryId})');
              } else {
                // Task doesn't exist, create new one
                task = Tasks()
                  ..title = onboardingTask.name
                  ..icon = onboardingTask.icon
                  ..category = onboardingTask.category
                  ..libraryId = onboardingTask.id
                  ..version = 1
                  ..isActive = true
                  ..isCustom = false
                  ..createdAt = DateTime.now()
                  ..modifiedAt = DateTime.now();

                await isar.tasks.put(task);
                print('[Onboarding] Created new task: ${task.title} (taskId: ${task.taskId}, libraryId: ${task.libraryId})');
              }

              processedTasks[onboardingTask.id] = task;
            }

            // Get schedule for this task
            final weekdays = _scheduleByMember[member.id]?[onboardingTask.id] ?? [];

            // weekdays already contains ISO days (1-7) from Step 3
            // No conversion needed - just sort and join
            final dbWeekdays = weekdays.toList()..sort();

            final frequency = dbWeekdays.join(',');

            // Create UserTask assignment
            final userTask = UserTasks()
              ..userId = userId
              ..taskId = task.taskId!
              ..checklistId = checklistId!
              ..frequency = frequency
              ..sortOrder = taskIndex
              ..isEnabled = true
              ..createdAt = DateTime.now()
              ..modifiedAt = DateTime.now();

            await isar.userTasks.put(userTask);
          }
        }
      });

      print('Data saved successfully! Checklist ID: $checklistId');

      // Navigate to Weekly Board with created checklist
      if (mounted) {
        context.go('/checklist/$checklistId');
      }
    } catch (e) {
      print('Error saving onboarding data: $e');
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with 4 screens
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe, use buttons only
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Screen 0: Welcome
              WelcomeScreen(
                onGetStarted: _goToNextPage,
              ),
              // Screen 1: Family Members
              Step1FamilyMembersScreen(
                onContinue: _onStep1Continue,
              ),
              // Screen 2: Choose Tasks (multi-member flow)
              _currentPage == 2 && _members.isNotEmpty && _currentMemberIndex < _members.length
                  ? Step2ChooseTasksScreen(
                      member: _members[_currentMemberIndex],
                      currentIndex: _currentMemberIndex,
                      totalMembers: _members.length,
                      allMembers: _members,
                      onContinue: _onStep2Continue,
                      initialSelectedTasks: _tasksByMember[_members[_currentMemberIndex].id],
                    )
                  : const SizedBox(), // Placeholder until data is ready
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
                onCreateChecklist: _completeOnboarding,
              ),
            ],
          ),
          // Progress indicators (only show on steps 1-3)
          if (_currentPage > 0)
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
          // Step indicator (only show on steps 1-3)
          if (_currentPage > 0)
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
        final isActive = index == _currentPage - 1; // -1 because welcome screen doesn't count
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
    if (_currentPage == 0) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Step $_currentPage/3',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF8E8E93),
        ),
      ),
    );
  }
}
