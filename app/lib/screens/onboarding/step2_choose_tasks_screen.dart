import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'step1_family_members_screen.dart';
import '../../widgets/weekday_selector.dart';
import '../../data/static/icon_library.dart';
import '../../data/static/category_definitions.dart';
import '../../data/static/task_library.dart';
import '../../data/repositories/tasks_repository.dart';

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
/// Note: Loads tasks from database (seeded from TaskLibrary)
/// Full implementation needs:
/// - Search functionality
/// - Custom task creation
class Step2ChooseTasksScreen extends ConsumerStatefulWidget {
  final FamilyMember member;
  final int currentIndex;
  final int totalMembers;
  final List<FamilyMember> allMembers; // All family members for task assignment
  final Function(String memberId, List<Task> selectedTasks) onContinue;
  final List<Task>? initialSelectedTasks; // Pre-selected tasks from database
  final int? checklistId; // For edit mode (to delete from DB)

  const Step2ChooseTasksScreen({
    super.key,
    required this.member,
    required this.currentIndex,
    required this.totalMembers,
    required this.allMembers,
    required this.onContinue,
    this.initialSelectedTasks,
    this.checklistId,
  });

  @override
  ConsumerState<Step2ChooseTasksScreen> createState() => _Step2ChooseTasksScreenState();
}

class _Step2ChooseTasksScreenState extends ConsumerState<Step2ChooseTasksScreen> {
  Set<String> _selectedCategories = {}; // Multiple categories can be selected
  final Set<String> _selectedTaskIds = {};
  final Set<String> _initiallySelectedTaskIds = {}; // Tasks from DB (show badge)
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<Task> _allTasks = [];
  bool _isLoadingTasks = true; // Track loading state

  @override
  void initState() {
    super.initState();

    print('[Step2] initState for member: ${widget.member.name} (${widget.member.id})');

    // Load tasks from database asynchronously
    // This will also process initialSelectedTasks after loading
    _loadTasksFromDatabase();
  }

  /// Load available tasks from database
  Future<void> _loadTasksFromDatabase() async {
    try {
      final tasksRepo = ref.read(tasksRepositoryProvider);
      final dbTasks = await tasksRepo.getAvailableTasks();

      print('[Step2] Loaded ${dbTasks.length} tasks from database');

      setState(() {
        _allTasks = dbTasks.map((dbTask) => Task(
          id: dbTask.libraryId ?? 'task_${dbTask.taskId}', // Use libraryId if available
          icon: dbTask.icon,
          name: dbTask.title,
          goal: '', // Goal text not stored in DB, will need to get from TaskLibrary if needed
          category: dbTask.category ?? 'other',
          frequency: 'daily', // Default frequency, will need to store in DB later if needed
        )).toList();
        _isLoadingTasks = false; // Mark as loaded
      });

      // Process initial selected tasks after loading from DB
      _processInitialSelectedTasks();
    } catch (e) {
      print('[Step2] Error loading tasks from database: $e');
      // Fallback to TaskLibrary if database fails
      setState(() {
        _allTasks = TaskLibrary.all.map((template) => Task(
          id: template.id,
          icon: template.icon,
          name: template.name,
          goal: template.goalText,
          category: template.category,
          frequency: template.frequency,
        )).toList();
        _isLoadingTasks = false; // Mark as loaded
      });
      _processInitialSelectedTasks();
    }
  }

  /// Process initially selected tasks from widget parameter
  void _processInitialSelectedTasks() {
    if (widget.initialSelectedTasks != null) {
      print('[Step2] Processing ${widget.initialSelectedTasks!.length} initialSelectedTasks');
      for (final task in widget.initialSelectedTasks!) {
        print('[Step2] Processing task: ${task.name} (icon: ${task.icon}, id: ${task.id})');

        // Try to find matching task in library by name and icon
        final matchingLibraryTask = _allTasks.firstWhere(
          (t) => t.name == task.name && t.icon == task.icon,
          orElse: () => task,
        );

        final taskIdToUse = matchingLibraryTask.id;
        print('[Step2] Using ID: $taskIdToUse for task ${task.name}');

        _selectedTaskIds.add(taskIdToUse);
        _initiallySelectedTaskIds.add(taskIdToUse);

        // Add task to _allTasks if it's not already there (custom tasks from DB)
        if (!_allTasks.any((t) => t.id == taskIdToUse)) {
          print('[Step2] Adding custom DB task to _allTasks: ${task.name}');
          _allTasks.add(task);
        }
      }
    } else {
      print('[Step2] No initialSelectedTasks provided');
    }
  }

  @override
  void didUpdateWidget(Step2ChooseTasksScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload selection when switching to a different member
    if (oldWidget.member.id != widget.member.id) {
      print('[Step2] didUpdateWidget: Member changed from ${oldWidget.member.name} to ${widget.member.name}');

      setState(() {
        _selectedTaskIds.clear();
        _initiallySelectedTaskIds.clear();
        _selectedCategories.clear();
        _searchQuery = '';
        _isLoadingTasks = true; // Show loading while reloading
      });
      _searchController.clear();

      // Reload tasks from database for the new member
      _loadTasksFromDatabase();

      print('[Step2] After didUpdateWidget: ${_selectedTaskIds.length} tasks selected, ${_allTasks.length} total tasks');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Task> get _filteredTasks {
    // If search is active, search across all categories
    if (_searchQuery.isNotEmpty) {
      return _allTasks.where((t) =>
        t.name.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    // If no categories selected, show all tasks
    if (_selectedCategories.isEmpty) {
      return _allTasks;
    }

    // Filter by selected categories
    return _allTasks.where((t) => _selectedCategories.contains(t.category)).toList();
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
    // Show loading indicator while tasks are being loaded
    if (_isLoadingTasks) {
      return const Scaffold(
        backgroundColor: Color(0xFFF5F5F7),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Reduced from 100
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
            // Search Bar (moved above tabs)
            _buildSearchBar(),
            const SizedBox(height: 12),
            // Category Tabs
            _buildCategoryTabs(),
            const SizedBox(height: 12),
            // Tasks List with scroll
            Expanded(
              child: _buildTasksList(),
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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTaskIds.remove(task.id);
                            });
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
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
                              ),
                              // Minus button in top right corner
                              Positioned(
                                top: -4,
                                right: -4,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: TaskCategories.all.map((category) {
          return _buildCategoryChip(category.name, category.id);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String category) {
    final isActive = _selectedCategories.contains(category);
    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle: add or remove from set
          if (isActive) {
            _selectedCategories.remove(category);
          } else {
            _selectedCategories.add(category);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0A7FCC) : const Color(0xFFE5E5EA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF3C3C43),
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
        // Tasks (removed frequency title)
        ...tasks.map((task) => _buildTaskItem(task)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTaskItem(Task task) {
    final isSelected = _selectedTaskIds.contains(task.id);
    final isInitiallySelected = _initiallySelectedTaskIds.contains(task.id);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon (no red badge - removed from list)
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Text(
                task.icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 12),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    task.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                      height: 1.2,
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
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Add/Check icon - properly centered
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFF0A7FCC),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 16,
                        color: const Color(0xFF0A7FCC),
                      )
                    : Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFC7C7CC),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF8E8E93),
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          // Square + button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF0A7FCC),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0A7FCC).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => _showCreateTaskDialog(),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchResult() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: Color(0xFFC7C7CC),
            ),
            const SizedBox(height: 16),
            Text(
              'No tasks found for "$_searchQuery"',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8E8E93),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Create Custom Task button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Show create custom task dialog
                  _showCreateTaskDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A7FCC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Create Custom Task',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTaskDialog() {
    // Pre-fill task name with search query
    final TextEditingController taskNameController = TextEditingController(
      text: _searchQuery.trim(),
    );
    String selectedIcon = '✨';
    // Default to first selected category or 'health'
    String selectedCategory = _selectedCategories.isNotEmpty ? _selectedCategories.first : 'health';

    // Initialize selected members: current member selected by default
    Set<String> selectedMemberIds = {widget.member.id};

    // Weekday selection (0=Sun, 1=Mon, ..., 6=Sat) - all days by default
    List<int> selectedWeekdays = [0, 1, 2, 3, 4, 5, 6];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header with iOS-style X button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(bottom: BorderSide(color: Color(0xFFF2F2F7), width: 1)),
                ),
                child: Row(
                  children: [
                    // iOS-style X button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5EA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'New Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Spacer to balance the X button
                    const SizedBox(width: 30),
                  ],
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon with edit badge
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final newIcon = await _showIconPickerDialog(context, selectedIcon);
                            if (newIcon != null) {
                              setState(() {
                                selectedIcon = newIcon;
                              });
                            }
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Round icon container
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    selectedIcon,
                                    style: const TextStyle(fontSize: 60),
                                  ),
                                ),
                              ),
                              // Green edit badge
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF34C759),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFF5F5F7), width: 3),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Task Name field (iOS style)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: taskNameController,
                          decoration: const InputDecoration(
                            hintText: 'Task Name',
                            hintStyle: TextStyle(color: Color(0xFFC7C7CC)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          ),
                          style: const TextStyle(fontSize: 17, color: Colors.black),
                          autofocus: true,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ASSIGNED TO section
                      const Text(
                        'ASSIGNED TO',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8E8E93),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: widget.allMembers.map((member) {
                          final isSelected = selectedMemberIds.contains(member.id);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedMemberIds.remove(member.id);
                                } else {
                                  selectedMemberIds.add(member.id);
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                          ? const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                            )
                                          : null,
                                        color: isSelected ? null : const Color(0xFFE5E5EA),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? const Color(0xFF0A7FCC) : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          member.avatar,
                                          style: const TextStyle(fontSize: 28),
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0A7FCC),
                                            shape: BoxShape.circle,
                                            border: Border.all(color: const Color(0xFFF5F5F7), width: 2),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  member.name.isEmpty ? 'Member' : member.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8E8E93),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),

                      // CATEGORY section
                      const Text(
                        'CATEGORY',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8E8E93),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // iOS-style segmented control
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5EA),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Row(
                          children: TaskCategories.all.map((category) {
                            return _buildCategorySegment(
                              category.icon,
                              category.name,
                              category.id,
                              selectedCategory,
                              (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // REGULARITY section (weekday selector)
                      const Text(
                        'REGULARITY',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8E8E93),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Weekday selector (reusable widget)
                      WeekdaySelector(
                        selectedDays: selectedWeekdays,
                        onDayToggle: (index) {
                          setState(() {
                            if (selectedWeekdays.contains(index)) {
                              selectedWeekdays.remove(index);
                            } else {
                              selectedWeekdays.add(index);
                              selectedWeekdays.sort();
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      // Quick select buttons
                      Row(
                        children: [
                          _buildQuickSelectButton('Weekdays', () {
                            setState(() {
                              selectedWeekdays = [1, 2, 3, 4, 5];
                            });
                          }),
                          const SizedBox(width: 8),
                          _buildQuickSelectButton('Weekend', () {
                            setState(() {
                              selectedWeekdays = [0, 6];
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 80), // Extra space for sticky button
                    ],
                  ),
                ),
              ),
              // Sticky "Add Task" button at bottom
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        final taskName = taskNameController.text.trim();
                        if (taskName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter a task name')),
                          );
                          return;
                        }

                        if (selectedMemberIds.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please assign to at least one member')),
                          );
                          return;
                        }

                        // Determine frequency based on weekdays
                        String frequency;
                        if (selectedWeekdays.length == 7) {
                          frequency = 'Daily';
                        } else if (selectedWeekdays.length >= 3) {
                          frequency = '${selectedWeekdays.length}x per Week';
                        } else {
                          frequency = 'Weekly';
                        }

                        // Create custom task
                        final customTask = Task(
                          id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
                          icon: selectedIcon,
                          name: taskName,
                          goal: '${selectedWeekdays.length}x weekly',
                          category: selectedCategory,
                          frequency: frequency,
                        );

                        // Add to task list
                        this.setState(() {
                          _allTasks.add(customTask);
                          _selectedTaskIds.add(customTask.id);
                          // Add selected category to filters
                          _selectedCategories.add(selectedCategory);
                          _searchQuery = '';
                          _searchController.clear();
                        });

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Custom task "$taskName" created!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A7FCC),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Add Task',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickSelectButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0A7FCC),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySegment(String icon, String label, String value, String selectedValue, Function(String) onSelect) {
    final isSelected = selectedValue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(value),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(icon, style: const TextStyle(fontSize: 13)),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: isSelected ? Colors.black : const Color(0xFF3C3C43).withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _showIconPickerDialog(BuildContext context, String currentIcon) async {
    Set<String> selectedCategories = {}; // Multiple categories can be selected

    // Helper to get filtered icons using IconLibrary
    List<String> getFilteredIcons() {
      if (selectedCategories.isEmpty) {
        // Show all free icons when no filter selected
        return IconLibrary.free.map((icon) => icon.emoji).toList();
      }
      // Combine icons from all selected categories (free only)
      return IconLibrary.byCategories(selectedCategories.toList())
          .where((icon) => !icon.isPremium)
          .map((icon) => icon.emoji)
          .toList();
    }

    return await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header with iOS-style X button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  border: Border(bottom: BorderSide(color: Color(0xFFF2F2F7), width: 1)),
                ),
                child: Row(
                  children: [
                    // iOS-style X button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5EA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Select Icon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Spacer to balance the X button
                    const SizedBox(width: 30),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Current icon preview
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            currentIcon,
                            style: const TextStyle(fontSize: 60),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Camera and Gallery buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildMediaButton(Icons.camera_alt, 'Camera', () {
                            // TODO: Implement camera
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Camera coming soon')),
                            );
                          }),
                          const SizedBox(width: 16),
                          _buildMediaButton(Icons.photo_library, 'Gallery', () {
                            // TODO: Implement gallery
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Gallery coming soon')),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Category chip filters (no "All" - multiple selection)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: TaskCategories.all.map((category) {
                          return _buildIconCategoryChip(
                            category.name,
                            category.id,
                            selectedCategories,
                            (categoryId) {
                              setState(() {
                                if (selectedCategories.contains(categoryId)) {
                                  selectedCategories.remove(categoryId);
                                } else {
                                  selectedCategories.add(categoryId);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Icon grid (7 columns, 30% smaller icons)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: getFilteredIcons().length,
                        itemBuilder: (context, index) {
                          final icon = getFilteredIcons()[index];
                          final isSelected = icon == currentIcon;
                          return GestureDetector(
                            onTap: () => Navigator.pop(context, icon),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF34C759) : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  icon,
                                  style: const TextStyle(fontSize: 22), // 30% smaller than 32
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: const Color(0xFF0A7FCC)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCategoryChip(String label, String category, Set<String> selectedCategories, Function(String) onTap) {
    final isActive = selectedCategories.contains(category);
    return GestureDetector(
      onTap: () => onTap(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0A7FCC) : const Color(0xFFE5E5EA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF3C3C43),
          ),
        ),
      ),
    );
  }
}

