import 'package:flutter/material.dart';
import 'step1_family_members_screen.dart';

/// Task model
class Task {
  final String id;
  final String icon;
  final String name;
  final String goal;
  final String category;
  final String frequency;

  Task({
    required this.id,
    required this.icon,
    required this.name,
    required this.goal,
    required this.category,
    required this.frequency,
  });
}

/// Screen 2 (Step 2/3): Choose tasks
/// Note: Simplified version - tasks are hardcoded
/// Full implementation needs:
/// - JSON task loading from onboarding-tasks.json
/// - Search functionality
/// - Custom task creation
class Step2ChooseTasksScreen extends StatefulWidget {
  final FamilyMember member;
  final int currentIndex;
  final int totalMembers;
  final Function(String memberId, List<Task> selectedTasks) onContinue;

  const Step2ChooseTasksScreen({
    super.key,
    required this.member,
    required this.currentIndex,
    required this.totalMembers,
    required this.onContinue,
  });

  @override
  State<Step2ChooseTasksScreen> createState() => _Step2ChooseTasksScreenState();
}

class _Step2ChooseTasksScreenState extends State<Step2ChooseTasksScreen> {
  String _currentCategory = 'health';
  final Set<String> _selectedTaskIds = {};

  // Hardcoded tasks for now (TODO: Load from JSON)
  final List<Task> _allTasks = [
    // Health - Daily
    Task(
      id: 'brush-teeth',
      icon: '🪥',
      name: 'Brush Teeth',
      goal: '14x weekly',
      category: 'health',
      frequency: 'Daily',
    ),
    Task(
      id: 'shower',
      icon: '🚿',
      name: 'Take Shower',
      goal: '7x weekly',
      category: 'health',
      frequency: 'Daily',
    ),
    Task(
      id: 'exercise',
      icon: '🏃',
      name: 'Exercise',
      goal: '5x weekly',
      category: 'health',
      frequency: 'Daily',
    ),
    // Home - Daily
    Task(
      id: 'tidy-room',
      icon: '🧹',
      name: 'Tidy Room',
      goal: '7x weekly',
      category: 'home',
      frequency: 'Daily',
    ),
    Task(
      id: 'dishes',
      icon: '🍽️',
      name: 'Wash Dishes',
      goal: '7x weekly',
      category: 'home',
      frequency: 'Daily',
    ),
    // Future - Daily
    Task(
      id: 'homework',
      icon: '📚',
      name: 'Do Homework',
      goal: '5x weekly',
      category: 'future',
      frequency: 'Daily',
    ),
    Task(
      id: 'reading',
      icon: '📖',
      name: 'Read Book',
      goal: '7x weekly',
      category: 'future',
      frequency: 'Daily',
    ),
  ];

  List<Task> get _filteredTasks {
    return _allTasks.where((t) => t.category == _currentCategory).toList();
  }

  Map<String, List<Task>> get _groupedTasks {
    final Map<String, List<Task>> grouped = {};
    for (final task in _filteredTasks) {
      grouped.putIfAbsent(task.frequency, () => []).add(task);
    }
    return grouped;
  }

  void _toggleTask(String taskId) {
    setState(() {
      if (_selectedTaskIds.contains(taskId)) {
        _selectedTaskIds.remove(taskId);
      } else {
        _selectedTaskIds.add(taskId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100), // Space for progress dots
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Tasks',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Show current member info
                  Row(
                    children: [
                      Text(
                        'Select tasks for ${widget.member.avatar} ',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFF8E8E93),
                          height: 1.4,
                        ),
                      ),
                      Text(
                        widget.member.name.isEmpty ? 'Member ${widget.currentIndex + 1}' : widget.member.name,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Active Tasks Panel
            _buildActiveTasksPanel(),
            const SizedBox(height: 16),
            // Category Tabs
            _buildCategoryTabs(),
            const SizedBox(height: 16),
            // Tasks List
            Expanded(
              child: _buildTasksList(),
            ),
            const SizedBox(height: 80), // Space for button
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 32, top: 12),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _selectedTaskIds.isEmpty
                ? null
                : () {
                    final selectedTasks = _allTasks
                        .where((t) => _selectedTaskIds.contains(t.id))
                        .toList();
                    widget.onContinue(widget.member.id, selectedTasks);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A7FCC),
              foregroundColor: Colors.white,
              disabledBackgroundColor:
                  const Color(0xFF0A7FCC).withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTasksPanel() {
    final selectedTasks = _allTasks.where((t) => _selectedTaskIds.contains(t.id)).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ACTIVE TASKS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8E8E93),
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '${_selectedTaskIds.length}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A7FCC),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Content
            Container(
              constraints: const BoxConstraints(minHeight: 50),
              child: selectedTasks.isEmpty
                  ? const Center(
                      child: Text(
                        'Please select tasks from list below',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFAEAEB2),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedTasks.map((task) {
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E5EA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              task.icon,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5EA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            _buildCategoryTab('🏃', 'Health', 'health'),
            _buildCategoryTab('🏠', 'Home', 'home'),
            _buildCategoryTab('🎯', 'Future', 'future'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String icon, String label, String category) {
    final isActive = _currentCategory == category;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentCategory = category;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 15)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: _groupedTasks.entries.map((entry) {
        return _buildTaskCategory(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildTaskCategory(String frequency, List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category title
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            frequency.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8E8E93),
              letterSpacing: 0.5,
            ),
          ),
        ),
        // Tasks
        ...tasks.map((task) => _buildTaskItem(task)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTaskItem(Task task) {
    final isSelected = _selectedTaskIds.contains(task.id);

    return GestureDetector(
      onTap: () => _toggleTask(task.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0A7FCC) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF0A7FCC) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            SizedBox(
              width: 32,
              child: Center(
                child: Text(
                  task.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.goal,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? Colors.white.withOpacity(0.8)
                          : const Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
            // Add/Check icon
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFF0A7FCC),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isSelected ? '✓' : '+',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? const Color(0xFF0A7FCC) : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
