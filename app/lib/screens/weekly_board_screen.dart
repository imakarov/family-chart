import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../data/repositories/checklist_repository.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../data/repositories/user_tasks_repository.dart';
import '../../../data/repositories/task_completions_repository.dart';
import '../../../data/repositories/tasks_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../data/models/users.dart';
import '../../../data/models/user_tasks.dart';
import '../../../data/models/tasks.dart';
import '../../../data/models/task_completions.dart';
import '../../../data/models/checklists.dart';
import '../../../core/utils/date_utils.dart' as app_date_utils;
import '../../../core/utils/week_day_helper.dart';
import '../../../core/providers/isar_provider.dart';
import '../../../widgets/app_menu_drawer.dart';

class WeeklyBoardScreen extends ConsumerStatefulWidget {
  final int checklistId;

  const WeeklyBoardScreen({
    super.key,
    required this.checklistId,
  });

  @override
  ConsumerState<WeeklyBoardScreen> createState() => _WeeklyBoardScreenState();
}

class _WeeklyBoardScreenState extends ConsumerState<WeeklyBoardScreen> {
  late int currentWeekNumber;
  late int currentWeekYear;
  late DateTime weekStart;
  int currentDayOfWeek = DateTime.now().weekday; // 1 = Monday, 7 = Sunday
  late int selectedDayOfWeek; // Selected day for editing (1-7)
  String? selectedFilter; // null = 'all', or userId

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentWeekNumber = app_date_utils.DateUtils.getWeekNumber(now);
    currentWeekYear = app_date_utils.DateUtils.getWeekYear(now);
    weekStart = app_date_utils.DateUtils.getWeekStartDate(currentWeekNumber, currentWeekYear);
    selectedDayOfWeek = currentDayOfWeek; // Default to current day
  }

  @override
  void dispose() {
    // Reset to current day when leaving screen
    selectedDayOfWeek = currentDayOfWeek;
    super.dispose();
  }

  void _selectDay(int dayOfWeek) {
    setState(() {
      selectedDayOfWeek = dayOfWeek;
    });
  }

  // DEBUG: Show reset dialog
  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Database'),
        content: const Text('Clear all data and return to onboarding?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final isar = await ref.read(isarProvider.future);
              await isar.writeTxn(() async {
                await isar.clear();
              });
              if (mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Scaffold(
                      body: Center(child: Text('Restarting...')),
                    ),
                  ),
                );
              }
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Grey background
      appBar: _buildAppBar(context),
      drawer: AppMenuDrawer(
        checklistId: widget.checklistId,
        showDashboardOption: true,
      ),
      body: FutureBuilder(
        future: _loadData(),
        builder: (context, AsyncSnapshot<_BoardData> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return _buildBody(data);
        },
      ),
      bottomNavigationBar: FutureBuilder(
        future: _loadData(),
        builder: (context, AsyncSnapshot<_BoardData> snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          return _buildBottomNav(snapshot.data!.users);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, size: 28, color: Color(0xFF0C7FCC)),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: GestureDetector(
        onLongPress: _showResetDialog,
        child: const Text(
          'Family Chart',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, size: 24, color: Color(0xFF0C7FCC)),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          color: const Color(0xFFD1D1D6),
        ),
      ),
    );
  }

  Widget _buildBody(_BoardData data) {
    // Filter members
    final filteredMembers = selectedFilter == null
        ? data.users
        : data.users.where((u) => u.userId.toString() == selectedFilter).toList();

    return Column(
      children: [
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeaderRow(),
                ...filteredMembers.expand((member) => _buildMemberSection(data, member)),
                const SizedBox(height: 90), // Space for bottom nav
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);
    final orderedDays = helper.orderedDays;

    return Row(
      children: [
        // Empty cell for member names
        Container(width: 110, height: 48),
        // Day cells
        ...List.generate(7, (uiIndex) {
          final isoDayOfWeek = orderedDays[uiIndex]; // ISO day (1-7)
          final isCurrent = isoDayOfWeek == currentDayOfWeek;
          final isSelected = isoDayOfWeek == selectedDayOfWeek;
          final isPast = isoDayOfWeek < currentDayOfWeek;
          final isClickable = isPast || isCurrent; // Can click on past and current days

          // Calculate the actual date for this UI column
          // For Sunday-first, we need to go back 1 day from Monday weekStart when uiIndex==0
          final date = weekStartDaySetting == 'sunday' && uiIndex == 0
              ? weekStart.subtract(const Duration(days: 1)) // Sunday before Monday
              : weekStart.add(Duration(days: uiIndex - (weekStartDaySetting == 'sunday' ? 1 : 0)));

          // Determine colors and expanded state
          Color bgColor;
          Color textColor;
          bool showExpanded;

          if (isSelected) {
            // This is the selected day
            if (isCurrent) {
              // Current day selected - blue
              bgColor = const Color(0xFF1CB0F6);
            } else {
              // Past day selected - gray
              bgColor = const Color(0xFF9E9E9E);
            }
            textColor = Colors.white;
            showExpanded = true;
          } else if (isCurrent) {
            // Current day but not selected - blue, narrow
            bgColor = const Color(0xFF1CB0F6);
            textColor = Colors.white;
            showExpanded = false;
          } else {
            // Other days - white
            bgColor = Colors.white;
            textColor = const Color(0xFF1A1A1A);
            showExpanded = false;
          }

          Widget dayCell = Container(
            height: showExpanded ? 48 : 34,
            margin: showExpanded ? null : const EdgeInsets.only(top: 12),
            alignment: showExpanded ? null : Alignment.bottomCenter,
            padding: showExpanded
                ? const EdgeInsets.symmetric(vertical: 6, horizontal: 4)
                : const EdgeInsets.only(bottom: 6, left: 4, right: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: showExpanded
                  ? const BorderRadius.vertical(top: Radius.circular(12))
                  : null,
              boxShadow: showExpanded
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(3, 0),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(-3, 0),
                      ),
                    ]
                  : null,
            ),
            child: showExpanded
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        helper.getShortLabel(isoDayOfWeek),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${date.day} ${DateFormat('MMM', 'ru').format(date)}',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: textColor.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Text(
                    helper.getShortLabel(isoDayOfWeek),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
          );

          // All days are Expanded with different flex values
          return Expanded(
            flex: showExpanded ? 56 : 30,
            child: isClickable
                ? GestureDetector(
                    onTap: () => _selectDay(isoDayOfWeek),
                    child: dayCell,
                  )
                : dayCell,
          );
        }),
      ],
    );
  }

  List<Widget> _buildMemberSection(_BoardData data, Users member) {
    // Get tasks for this member
    final memberUserTasks = data.userTasks
        .where((ut) => ut.userId == member.userId)
        .toList();

    final widgets = <Widget>[];

    // Member header row
    widgets.add(_buildMemberHeaderRow(data, member));

    // Task rows
    for (final userTask in memberUserTasks) {
      final task = data.tasks.firstWhere((t) => t.taskId == userTask.taskId);
      widgets.add(_buildTaskRow(data, member, userTask, task));
    }

    return widgets;
  }

  Widget _buildMemberHeaderRow(_BoardData data, Users member) {
    final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);
    final orderedDays = helper.orderedDays;

    return Row(
      children: [
        // Member cell
        Container(
          width: 110,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF0A7FCC),
            border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _parseColor(member.colorHex),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    member.name[0],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Name
              Expanded(
                child: Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        // Day cells with stars
        ...List.generate(7, (uiIndex) {
          final isoDayOfWeek = orderedDays[uiIndex]; // ISO day (1-7)
          final dayIndex = isoDayOfWeek - 1; // 0-based index for date calculation
          final isCurrent = isoDayOfWeek == currentDayOfWeek;
          final isSelected = isoDayOfWeek == selectedDayOfWeek;
          final isPast = isoDayOfWeek < currentDayOfWeek;
          final isClickable = isPast || isCurrent;

          // Determine background color and expanded state
          Color bgColor;
          bool showExpanded;
          bool showShadow;

          if (isSelected) {
            // This is the selected day
            if (isCurrent) {
              // Current day selected - blue
              bgColor = const Color(0xFF1CB0F6);
            } else {
              // Past day selected - gray
              bgColor = const Color(0xFF9E9E9E);
            }
            showExpanded = true;
            showShadow = true;
          } else if (isCurrent) {
            // Current day but not selected - blue, narrow
            bgColor = const Color(0xFF1CB0F6);
            showExpanded = false;
            showShadow = false;
          } else {
            // Other days - default blue
            bgColor = const Color(0xFF0A7FCC);
            showExpanded = false;
            showShadow = false;
          }

          final star = _getMemberDayStar(data, member, dayIndex, showExpanded);

          Widget dayCell = Container(
            height: 56,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
              boxShadow: showShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(3, 0),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(-3, 0),
                      ),
                    ]
                  : null,
            ),
            child: Center(child: star),
          );

          // All days are Expanded with different flex values
          return Expanded(
            flex: showExpanded ? 56 : 30,
            child: isClickable
                ? GestureDetector(
                    onTap: () => _selectDay(isoDayOfWeek),
                    child: dayCell,
                  )
                : dayCell,
          );
        }),
      ],
    );
  }

  Widget _getMemberDayStar(_BoardData data, Users member, int dayIndex, bool showExpanded) {
    // Don't show stars for future days
    if (dayIndex > currentDayOfWeek - 1) {
      return const SizedBox();
    }

    // Fix date calculation for Sunday-first mode
    final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);
    final orderedDays = helper.orderedDays;

    // Find uiIndex for this dayIndex
    final isoDayOfWeek = dayIndex + 1; // Convert 0-based to ISO day (1-7)
    final uiIndex = orderedDays.indexOf(isoDayOfWeek);

    final date = weekStartDaySetting == 'sunday' && uiIndex == 0
        ? weekStart.subtract(const Duration(days: 1)) // Sunday before Monday
        : weekStart.add(Duration(days: uiIndex - (weekStartDaySetting == 'sunday' ? 1 : 0)));

    // Get all tasks for this member on this day
    final memberUserTasks = data.userTasks
        .where((ut) => ut.userId == member.userId)
        .toList();

    final tasksForDay = memberUserTasks.where((ut) {
      final frequencyDays = ut.frequency.split(',').map(int.parse).toList();
      return frequencyDays.contains(dayIndex + 1); // dayIndex is 0-based, weekday is 1-based
    }).toList();

    if (tasksForDay.isEmpty) return const SizedBox();

    // Check if all tasks are completed
    final allCompleted = tasksForDay.every((ut) {
      final completion = data.completions.firstWhere(
        (c) =>
            c.userId == member.userId &&
            c.taskId == ut.taskId &&
            c.completionDate.year == date.year &&
            c.completionDate.month == date.month &&
            c.completionDate.day == date.day,
        orElse: () => TaskCompletions()
          ..userId = 0
          ..taskId = 0
          ..weekNumber = 0
          ..weekYear = 0
          ..dayOfWeek = 0
          ..completionDate = DateTime(1970)
          ..isCompleted = false,
      );
      return completion.isCompleted;
    });

    if (allCompleted) {
      return Text(
        '⭐',
        style: TextStyle(
          fontSize: showExpanded ? 20 : 14,
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildTaskRow(_BoardData data, Users member, UserTasks userTask, Tasks task) {
    // Calculate progress
    final frequencyDays = userTask.frequency.split(',').map(int.parse).toList();
    final totalDays = frequencyDays.length;
    int completedDays = 0;

    // Get week start day setting for date calculation
    final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);
    final orderedDays = helper.orderedDays;

    for (final dayNum in frequencyDays) {
      final dayIndex = dayNum - 1; // Convert to 0-based

      // Fix date calculation for Sunday-first mode
      final isoDayOfWeek = dayIndex + 1; // Convert 0-based to ISO day (1-7)
      final uiIndex = orderedDays.indexOf(isoDayOfWeek);

      final date = weekStartDaySetting == 'sunday' && uiIndex == 0
          ? weekStart.subtract(const Duration(days: 1)) // Sunday before Monday
          : weekStart.add(Duration(days: uiIndex - (weekStartDaySetting == 'sunday' ? 1 : 0)));

      final completion = data.completions.firstWhere(
        (c) =>
            c.userId == member.userId &&
            c.taskId == task.taskId &&
            c.completionDate.year == date.year &&
            c.completionDate.month == date.month &&
            c.completionDate.day == date.day,
        orElse: () => TaskCompletions()
          ..userId = 0
          ..taskId = 0
          ..weekNumber = 0
          ..weekYear = 0
          ..dayOfWeek = 0
          ..completionDate = DateTime(1970)
          ..isCompleted = false,
      );

      if (completion.isCompleted) {
        completedDays++;
      }
    }

    final progressPercent = totalDays > 0 ? (completedDays / totalDays) : 0.0;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Task label cell
            Container(
              width: 110,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: const Color(0xFFF5F5F7),
          child: Row(
            children: [
              // Progress bar
              Container(
                width: 2.5,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: progressPercent,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF58CC02), Color(0xFF4CAD02)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Task label
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
            // Day cells
            ...List.generate(7, (uiIndex) {
              final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
              final helper = WeekDayHelper(weekStartDaySetting);
              final orderedDays = helper.orderedDays;
              final isoDayOfWeek = orderedDays[uiIndex]; // ISO day (1-7)
              final dayIndex = isoDayOfWeek - 1; // 0-based index for date calculation
              return _buildTaskDayCell(data, member, userTask, task, dayIndex);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskDayCell(_BoardData data, Users member, UserTasks userTask, Tasks task, int dayIndex) {
    final isoDayOfWeek = dayIndex + 1; // Convert 0-based to ISO day (1-7)
    final isCurrent = isoDayOfWeek == currentDayOfWeek;
    final isSelected = isoDayOfWeek == selectedDayOfWeek;
    final isPast = isoDayOfWeek < currentDayOfWeek;
    final isFuture = isoDayOfWeek > currentDayOfWeek;

    final frequencyDays = userTask.frequency.split(',').map(int.parse).toList();
    final hasTask = frequencyDays.contains(dayIndex + 1); // dayIndex is 0-based, weekday is 1-based

    // Fix date calculation for Sunday-first mode
    final weekStartDaySetting = ref.watch(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);
    final orderedDays = helper.orderedDays;

    final uiIndex = orderedDays.indexOf(isoDayOfWeek);

    final date = weekStartDaySetting == 'sunday' && uiIndex == 0
        ? weekStart.subtract(const Duration(days: 1)) // Sunday before Monday
        : weekStart.add(Duration(days: uiIndex - (weekStartDaySetting == 'sunday' ? 1 : 0)));

    final completion = data.completions.firstWhere(
      (c) =>
          c.userId == member.userId &&
          c.taskId == task.taskId &&
          c.completionDate.year == date.year &&
          c.completionDate.month == date.month &&
          c.completionDate.day == date.day,
      orElse: () => TaskCompletions()
        ..userId = 0
        ..taskId = 0
        ..weekNumber = 0
        ..weekYear = 0
        ..dayOfWeek = 0
        ..completionDate = DateTime(1970)
        ..isCompleted = false,
    );

    final isCompleted = completion.isCompleted;

    // Determine if this day should be expanded
    bool showExpanded;
    Color bgColor;

    if (isSelected) {
      // Selected day (current or past)
      showExpanded = true;
      bgColor = Colors.white;
    } else if (isCurrent) {
      // Current day but not selected - narrow
      showExpanded = false;
      bgColor = const Color(0xFFF5F5F7);
    } else {
      // Other days
      showExpanded = false;
      bgColor = const Color(0xFFF5F5F7);
    }

    Widget dayCell = Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      color: bgColor,
      child: hasTask
          ? _buildTaskItem(member, task, date, isPast, isSelected, isFuture, isCompleted)
          : const SizedBox(),
    );

    // All days are Expanded with different flex values
    return Expanded(
      flex: showExpanded ? 56 : 30,
      child: dayCell,
    );
  }

  Widget _buildTaskItem(
    Users member,
    Tasks task,
    DateTime date,
    bool isPast,
    bool isSelected,
    bool isFuture,
    bool isCompleted,
  ) {
    Widget itemContent;

    if (!isSelected) {
      // Non-selected days - show only circle dot (●), NO icons!
      // Add padding to match the height of the selected day icons (42px)
      itemContent = Container(
        height: 42,
        alignment: Alignment.center,
        child: Text(
          '●',
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? const Color(0xFF58CC02) : const Color(0xFFD1D1D6),
          ),
        ),
      );
    } else {
      // Selected day only - show emoji icon with inset shadow
      // Size is always 42x42 for selected day
      if (isCompleted) {
        // Completed - green gradient background
        itemContent = Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF58CC02), Color(0xFF4CAD02)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF58CC02).withOpacity(0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: const Color(0xFF58CC02).withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              task.icon,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        );
      } else {
        // Not completed - inset shadow (pressed effect)
        itemContent = Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8), // Slightly darker base
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              // Outer subtle shadow
              BoxShadow(
                color: Color(0x0D000000), // rgba(0, 0, 0, 0.05)
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD0D0D0), // Darker top-left (simulates inset shadow)
                  Color(0xFFF5F5F5), // Lighter bottom-right
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                task.icon,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () => _toggleCompletion(member, task, date),
      child: Center(child: itemContent),
    );
  }

  Future<void> _toggleCompletion(Users member, Tasks task, DateTime date) async {
    final repo = ref.read(taskCompletionsRepositoryProvider);
    final dayOfWeek = date.weekday; // 1 = Monday, 7 = Sunday
    final weekNumber = app_date_utils.DateUtils.getWeekNumber(date);
    final weekYear = app_date_utils.DateUtils.getWeekYear(date);

    await repo.toggleCompletion(
      member.userId,
      task.taskId,
      weekNumber,
      weekYear,
      dayOfWeek,
      widget.checklistId,
      date, // Pass the actual date for the day being toggled
    );
    setState(() {}); // Refresh UI
  }

  Widget _buildBottomNav(List<Users> users) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF053656),
        boxShadow: [
          BoxShadow(
            color: Color(0x261CB0F6),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // "All" tab
          _buildTabItem(
            label: 'All',
            icon: Icons.family_restroom,
            isActive: selectedFilter == null,
            onTap: () => setState(() => selectedFilter = null),
          ),
          // Individual member tabs
          ...users.map((user) => _buildTabItem(
                label: user.name,
                icon: Icons.person,
                isActive: selectedFilter == user.userId.toString(),
                color: _parseColor(user.colorHex),
                onTap: () => setState(() => selectedFilter = user.userId.toString()),
              )),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required IconData icon,
    required bool isActive,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(35),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color ?? Colors.grey,
                ),
                child: Center(
                  child: Text(
                    label[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? const Color(0xFF1CB0F6)
                      : Colors.white.withOpacity(0.8),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return Colors.grey;
    }

    final hex = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  Future<_BoardData> _loadData() async {
    final checklist = await ref.read(checklistRepositoryProvider).getChecklistById(widget.checklistId);
    final users = await ref.read(usersRepositoryProvider).getAllUsers();
    final userTasks = await ref.read(userTasksRepositoryProvider).getUserTasksByChecklistId(widget.checklistId);
    final tasks = await ref.read(tasksRepositoryProvider).getAllTasks();
    final completions = await ref.read(taskCompletionsRepositoryProvider).getCompletionsByWeek(
          currentWeekNumber,
          currentWeekYear,
          widget.checklistId,
        );

    return _BoardData(
      checklist: checklist,
      users: users,
      userTasks: userTasks,
      tasks: tasks,
      completions: completions,
    );
  }
}

class _BoardData {
  final Checklists? checklist;
  final List<Users> users;
  final List<UserTasks> userTasks;
  final List<Tasks> tasks;
  final List<TaskCompletions> completions;

  _BoardData({
    required this.checklist,
    required this.users,
    required this.userTasks,
    required this.tasks,
    required this.completions,
  });
}
