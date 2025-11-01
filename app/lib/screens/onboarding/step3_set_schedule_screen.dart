import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'step1_family_members_screen.dart';
import 'step2_choose_tasks_screen.dart';
import '../../widgets/weekday_selector.dart';
import '../../data/repositories/settings_repository.dart';
import '../../core/utils/week_day_helper.dart';

/// Screen 3 (Step 3/3): Set schedule for tasks
class Step3SetScheduleScreen extends ConsumerStatefulWidget {
  final List<FamilyMember> members;
  final Map<String, List<Task>> tasksByMember;
  final Map<String, Map<String, List<int>>> scheduleByMember;
  final Function(String memberId, String taskId, List<int> weekdays) onScheduleUpdate;
  final VoidCallback onCreateChecklist;
  final bool isEditMode; // true = edit mode, false = create mode
  final int? checklistId; // For edit mode

  const Step3SetScheduleScreen({
    super.key,
    required this.members,
    required this.tasksByMember,
    required this.scheduleByMember,
    required this.onScheduleUpdate,
    required this.onCreateChecklist,
    this.isEditMode = false,
    this.checklistId,
  });

  @override
  ConsumerState<Step3SetScheduleScreen> createState() => _Step3SetScheduleScreenState();
}

class _Step3SetScheduleScreenState extends ConsumerState<Step3SetScheduleScreen> {
  final Map<String, bool> _expandedMembers = {};

  @override
  void initState() {
    super.initState();
    // Expand all members by default
    for (final member in widget.members) {
      _expandedMembers[member.id] = true;
    }
  }

  void _toggleWeekday(String memberId, String taskId, int uiIndex) {
    // Get weekStartDay setting to determine conversion
    final weekStartDaySetting = ref.read(weekStartDayProvider).value ?? 'monday';
    final helper = WeekDayHelper(weekStartDaySetting);

    // Convert UI index to ISO day
    final isoDayOfWeek = helper.getIsoDay(uiIndex);

    // Get current ISO days stored in DB
    final currentDays = List<int>.from(widget.scheduleByMember[memberId]?[taskId] ?? []);

    if (currentDays.contains(isoDayOfWeek)) {
      currentDays.remove(isoDayOfWeek);
    } else {
      currentDays.add(isoDayOfWeek);
      currentDays.sort();
    }

    widget.onScheduleUpdate(memberId, taskId, currentDays);
  }

  void _setQuickSelect(String memberId, String taskId, String type) {
    List<int> weekdays;
    if (type == 'weekdays') {
      weekdays = [1, 2, 3, 4, 5]; // Mon-Fri (ISO days)
    } else {
      weekdays = [6, 7]; // Sat-Sun (ISO days)
    }
    widget.onScheduleUpdate(memberId, taskId, weekdays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Reduced from 100
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Set Schedule',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose which days to do each task',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF8E8E93),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Members list with tasks (scrollable)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: widget.members.length,
                itemBuilder: (context, index) {
                  final member = widget.members[index];
                  final tasks = widget.tasksByMember[member.id] ?? [];
                  final isExpanded = _expandedMembers[member.id] ?? false;

                  return _buildMemberSection(member, tasks, isExpanded);
                },
              ),
            ),
            const SizedBox(height: 12), // Reduced from 80
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 34, top: 8),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: widget.onCreateChecklist,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A7FCC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
              shadowColor: const Color(0xFF0A7FCC).withOpacity(0.3),
            ),
            child: Text(
              widget.isEditMode ? 'Save Changes' : 'Create Checklist',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberSection(FamilyMember member, List<Task> tasks, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Member header (collapsible)
          InkWell(
            onTap: () {
              setState(() {
                _expandedMembers[member.id] = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Text(
                        member.avatar,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Name and task count
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name.isEmpty ? 'Member' : member.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${tasks.length} ${tasks.length == 1 ? 'task' : 'tasks'}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expand/collapse icon
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF8E8E93),
                  ),
                ],
              ),
            ),
          ),
          // Tasks list (collapsible)
          if (isExpanded && tasks.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF2F2F7), width: 1),
                ),
              ),
              child: Column(
                children: tasks.map((task) {
                  final schedule = widget.scheduleByMember[member.id]?[task.id] ?? [];
                  return _buildTaskRow(member.id, task, schedule);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskRow(String memberId, Task task, List<int> selectedDays) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF2F2F7), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task name with icon and quick select buttons
          Row(
            children: [
              Text(
                task.icon,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  task.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Quick select buttons on the right
              _buildQuickSelectButton('Weekdays', () => _setQuickSelect(memberId, task.id, 'weekdays')),
              const SizedBox(width: 6),
              _buildQuickSelectButton('Weekend', () => _setQuickSelect(memberId, task.id, 'weekend')),
            ],
          ),
          const SizedBox(height: 12),
          // Weekday selector (reusable widget)
          WeekdaySelector(
            selectedDays: selectedDays,
            onDayToggle: (index) => _toggleWeekday(memberId, task.id, index),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSelectButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0A7FCC),
          ),
        ),
      ),
    );
  }
}
