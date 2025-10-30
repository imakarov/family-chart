import 'category_definitions.dart';

/// Task template definition
class TaskTemplate {
  final String id;
  final String name;
  final String icon;
  final String category; // 'health', 'home', 'future'
  final String frequency; // 'Daily', '3x per Week', 'Weekly'
  final int weeklyGoal; // Number of times per week
  final bool needsApproval; // Requires parent approval
  final int priority; // Lower number = higher priority (for sorting)
  final List<String> cohorts; // Age groups: 'preschool', 'earlySchool', 'middleSchool', 'preTeen'

  const TaskTemplate({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.frequency,
    required this.weeklyGoal,
    this.needsApproval = false,
    this.priority = 50,
    this.cohorts = const [],
  });

  /// Get goal display text
  String get goalText => '${weeklyGoal}x weekly';

  /// Check if task is for a specific cohort
  bool isForCohort(String cohort) => cohorts.isEmpty || cohorts.contains(cohort);

  /// Check if task is daily
  bool get isDaily => frequency == 'Daily';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTemplate &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Complete task library with all pre-defined tasks
/// Tasks are organized by category and sorted by priority (most common first)
class TaskLibrary {
  // ========== HEALTH TASKS (sorted by popularity) ==========
  static const List<TaskTemplate> health = [
    // Top tier - Universal daily health tasks (priority 1-10)
    TaskTemplate(
      id: 'brush-teeth',
      name: 'Brush Teeth',
      icon: '🪥',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 14,
      priority: 1,
      cohorts: ['preschool', 'earlySchool', 'middleSchool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'wash-hands',
      name: 'Wash Hands',
      icon: '🧼',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 14,
      priority: 2,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'shower',
      name: 'Shower/Bath',
      icon: '🚿',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 3,
      cohorts: ['earlySchool', 'middleSchool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'get-dressed',
      name: 'Get Dressed',
      icon: '👕',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 4,
      cohorts: ['preschool', 'earlySchool'],
    ),

    // Mid tier - Nutrition (priority 11-20)
    TaskTemplate(
      id: 'eat-vegetables',
      name: 'Eat Vegetables',
      icon: '🥦',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 11,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'eat-healthy',
      name: 'Eat Healthy Meals',
      icon: '🥗',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 12,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'healthy-eating',
      name: 'Eat Balanced Meals',
      icon: '🥗',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 13,
      cohorts: ['middleSchool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'drink-water',
      name: 'Drink Water (5 cups)',
      icon: '💧',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 14,
      cohorts: ['preschool', 'earlySchool'],
    ),

    // Physical activity (priority 21-30)
    TaskTemplate(
      id: 'play-outside',
      name: 'Play Outside (30m)',
      icon: '⚽',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 21,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'sport-activity',
      name: 'Sport/Activity',
      icon: '⚽',
      category: 'health',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 22,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'exercise',
      name: 'Exercise/Sport',
      icon: '🏃',
      category: 'health',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 23,
      cohorts: ['middleSchool', 'preTeen'],
    ),

    // Screen time & sleep (priority 31-40)
    TaskTemplate(
      id: 'limit-screen',
      name: 'Limit Screen Time (1h)',
      icon: '📱',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 31,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'screen-limit-ms',
      name: 'Limit Screen Time (1.5h)',
      icon: '📱',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 32,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'screen-limit-pt',
      name: 'Limit Screen Time (2h)',
      icon: '📱',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 33,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'sleep-schedule',
      name: 'Keep Sleep Schedule',
      icon: '😴',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 34,
      cohorts: ['middleSchool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'sleep-pt',
      name: 'Sleep 8+ Hours',
      icon: '😴',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 35,
      cohorts: ['preTeen'],
    ),

    // Hygiene (priority 41-50)
    TaskTemplate(
      id: 'maintain-hygiene',
      name: 'Personal Hygiene',
      icon: '🚿',
      category: 'health',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 41,
      cohorts: ['preTeen'],
    ),
  ];

  // ========== HOME TASKS (sorted by popularity) ==========
  static const List<TaskTemplate> home = [
    // Top tier - Daily organization (priority 1-10)
    TaskTemplate(
      id: 'make-bed',
      name: 'Make Bed',
      icon: '🛏️',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 1,
      cohorts: ['preschool', 'earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'tidy-toys',
      name: 'Tidy Toys',
      icon: '🧸',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 2,
      cohorts: ['preschool'],
    ),
    TaskTemplate(
      id: 'tidy-room',
      name: 'Tidy Room',
      icon: '🧹',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 3,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'clean-room',
      name: 'Clean Room',
      icon: '🧹',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 4,
      cohorts: ['preschool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'chores',
      name: 'Complete Chores',
      icon: '🏠',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 5,
      cohorts: ['preTeen'],
    ),

    // Kitchen & meals (priority 11-20)
    TaskTemplate(
      id: 'help-set-table',
      name: 'Help Set Table',
      icon: '🍽️',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 11,
      cohorts: ['preschool'],
    ),
    TaskTemplate(
      id: 'help-dishes',
      name: 'Help with Dishes',
      icon: '🍽️',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 12,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'dishes-pt',
      name: 'Do Dishes',
      icon: '🍽️',
      category: 'home',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 13,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'help-cook',
      name: 'Help Cook',
      icon: '👨‍🍳',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 14,
      needsApproval: true,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'cook-meal',
      name: 'Cook a Meal',
      icon: '👨‍🍳',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 15,
      needsApproval: true,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'cook-meals',
      name: 'Cook Family Meal',
      icon: '👨‍🍳',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 16,
      needsApproval: true,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'meal-prep',
      name: 'Help Meal Prep',
      icon: '🥘',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 17,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'meal-planning',
      name: 'Help Plan Meals',
      icon: '📋',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 18,
      cohorts: ['preTeen'],
    ),

    // Laundry & organization (priority 21-30)
    TaskTemplate(
      id: 'put-shoes-away',
      name: 'Put Shoes Away',
      icon: '👟',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 21,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'pack-backpack',
      name: 'Pack Backpack',
      icon: '🎒',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 22,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'fold-clothes',
      name: 'Fold Clothes',
      icon: '👔',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 23,
      cohorts: ['earlySchool'],
    ),
    TaskTemplate(
      id: 'laundry',
      name: 'Do Own Laundry',
      icon: '🧺',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 24,
      cohorts: ['middleSchool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'organize-desk',
      name: 'Organize Desk',
      icon: '🗂️',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 25,
      cohorts: ['earlySchool'],
    ),
    TaskTemplate(
      id: 'organize-space',
      name: 'Organize Personal Space',
      icon: '📦',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 26,
      cohorts: ['middleSchool'],
    ),

    // Pets & plants (priority 31-40)
    TaskTemplate(
      id: 'feed-pet',
      name: 'Feed Pet',
      icon: '🐕',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 31,
      cohorts: ['preschool', 'earlySchool'],
    ),
    TaskTemplate(
      id: 'walk-pet',
      name: 'Walk Pet',
      icon: '🐕',
      category: 'home',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 32,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'water-plants',
      name: 'Water Plants',
      icon: '🌱',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 33,
      cohorts: ['preschool', 'earlySchool'],
    ),

    // Family & helping (priority 41-50)
    TaskTemplate(
      id: 'help-sibling',
      name: 'Help Sibling',
      icon: '👥',
      category: 'home',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 41,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'mentor-sibling',
      name: 'Mentor Sibling',
      icon: '👥',
      category: 'home',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 42,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'help-parent',
      name: 'Help Parent with Task',
      icon: '🤝',
      category: 'home',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 43,
      needsApproval: true,
      cohorts: ['middleSchool'],
    ),

    // Cleaning tasks (priority 51-60)
    TaskTemplate(
      id: 'take-out-trash',
      name: 'Take Out Trash',
      icon: '🗑️',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 51,
      cohorts: ['earlySchool'],
    ),
    TaskTemplate(
      id: 'vacuum-clean',
      name: 'Vacuum Room',
      icon: '🧹',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 52,
      cohorts: ['middleSchool'],
    ),

    // Shopping & errands (priority 61-70)
    TaskTemplate(
      id: 'grocery-help',
      name: 'Help with Groceries',
      icon: '🛒',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 61,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'grocery-shopping',
      name: 'Grocery Shopping',
      icon: '🛒',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 62,
      needsApproval: true,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'car-wash',
      name: 'Wash Car',
      icon: '🚗',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 63,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'yard-work',
      name: 'Yard Work',
      icon: '🌳',
      category: 'home',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 64,
      cohorts: ['preTeen'],
    ),
  ];

  // ========== FUTURE (Education & Skills) TASKS (sorted by popularity) ==========
  static const List<TaskTemplate> future = [
    // Top tier - School work (priority 1-10)
    TaskTemplate(
      id: 'homework',
      name: 'Homework',
      icon: '📝',
      category: 'future',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 1,
      needsApproval: true,
      cohorts: ['earlySchool', 'middleSchool', 'preTeen'],
    ),
    TaskTemplate(
      id: 'reading',
      name: 'Reading (20m)',
      icon: '📖',
      category: 'future',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 2,
      cohorts: ['earlySchool', 'middleSchool'],
    ),
    TaskTemplate(
      id: 'read-learn',
      name: 'Read/Learn (30m)',
      icon: '📖',
      category: 'future',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 3,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'study',
      name: 'Study/Review (45m)',
      icon: '📚',
      category: 'future',
      frequency: 'Daily',
      weeklyGoal: 5,
      priority: 4,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'study-ahead',
      name: 'Study Ahead',
      icon: '📚',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 5,
      cohorts: ['middleSchool'],
    ),

    // Early learning (priority 11-20)
    TaskTemplate(
      id: 'story-time',
      name: 'Story Time (15m)',
      icon: '📚',
      category: 'future',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 11,
      cohorts: ['preschool'],
    ),
    TaskTemplate(
      id: 'practice-letters',
      name: 'Practice Letters',
      icon: '✏️',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 12,
      cohorts: ['preschool'],
    ),
    TaskTemplate(
      id: 'write-journal',
      name: 'Write Journal',
      icon: '📔',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 13,
      cohorts: ['earlySchool'],
    ),

    // Skills & hobbies (priority 21-30)
    TaskTemplate(
      id: 'practice-instrument',
      name: 'Practice Instrument',
      icon: '🎵',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 21,
      cohorts: ['earlySchool'],
    ),
    TaskTemplate(
      id: 'practice-skill',
      name: 'Practice Skill/Hobby',
      icon: '🎸',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 22,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'skill-development',
      name: 'Develop Skill/Hobby',
      icon: '🎯',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 23,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'draw-art',
      name: 'Draw/Art Time',
      icon: '🎨',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 24,
      cohorts: ['preschool'],
    ),
    TaskTemplate(
      id: 'creative-project',
      name: 'Work on Project',
      icon: '🎨',
      category: 'future',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 25,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'project-work',
      name: 'Personal Project',
      icon: '🎨',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 26,
      cohorts: ['preTeen'],
    ),

    // Learning & technology (priority 31-40)
    TaskTemplate(
      id: 'learn-new-skill',
      name: 'Learn New Skill',
      icon: '💡',
      category: 'future',
      frequency: 'Weekly',
      weeklyGoal: 2,
      priority: 31,
      cohorts: ['earlySchool'],
    ),
    TaskTemplate(
      id: 'learn-online',
      name: 'Online Learning',
      icon: '💻',
      category: 'future',
      frequency: '3x per Week',
      weeklyGoal: 3,
      priority: 32,
      cohorts: ['middleSchool'],
    ),
    TaskTemplate(
      id: 'organize-files',
      name: 'Organize Digital Files',
      icon: '💻',
      category: 'future',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 33,
      cohorts: ['preTeen'],
    ),

    // Life skills (priority 41-50)
    TaskTemplate(
      id: 'manage-schedule',
      name: 'Manage Own Schedule',
      icon: '📅',
      category: 'future',
      frequency: 'Daily',
      weeklyGoal: 7,
      priority: 41,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'budget-track',
      name: 'Track Budget/Allowance',
      icon: '💰',
      category: 'future',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 42,
      cohorts: ['preTeen'],
    ),
    TaskTemplate(
      id: 'volunteer-help',
      name: 'Volunteer/Community',
      icon: '🤝',
      category: 'future',
      frequency: 'Weekly',
      weeklyGoal: 1,
      priority: 43,
      needsApproval: true,
      cohorts: ['preTeen'],
    ),
  ];

  // ========== ALL TASKS ==========
  /// Complete list of all tasks across all categories
  static const List<TaskTemplate> all = [
    ...health,
    ...home,
    ...future,
  ];

  // ========== UTILITY METHODS ==========

  /// Get all tasks for a specific category (sorted by priority)
  static List<TaskTemplate> byCategory(String categoryId) {
    final tasks = all.where((task) => task.category == categoryId).toList();
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    return tasks;
  }

  /// Get all tasks for a specific cohort (sorted by priority within category)
  static List<TaskTemplate> byCohort(String cohort) {
    final tasks = all.where((task) => task.isForCohort(cohort)).toList();
    tasks.sort((a, b) {
      // First sort by category, then by priority
      final categoryCompare = a.category.compareTo(b.category);
      if (categoryCompare != 0) return categoryCompare;
      return a.priority.compareTo(b.priority);
    });
    return tasks;
  }

  /// Get tasks for category and cohort (sorted by priority)
  static List<TaskTemplate> byCategoryAndCohort(String categoryId, String cohort) {
    final tasks = all.where((task) =>
      task.category == categoryId && task.isForCohort(cohort)
    ).toList();
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    return tasks;
  }

  /// Get top N tasks for a cohort (across all categories, sorted by priority)
  static List<TaskTemplate> topTasksForCohort(String cohort, {int limit = 5}) {
    final tasks = byCohort(cohort);
    return tasks.take(limit).toList();
  }

  /// Search tasks by name
  static List<TaskTemplate> search(String query) {
    final lowerQuery = query.toLowerCase();
    return all.where((task) =>
      task.name.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  /// Get task by ID
  static TaskTemplate? getById(String id) {
    try {
      return all.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all daily tasks
  static List<TaskTemplate> get dailyTasks {
    return all.where((task) => task.isDaily).toList();
  }

  /// Get all tasks that need approval
  static List<TaskTemplate> get tasksNeedingApproval {
    return all.where((task) => task.needsApproval).toList();
  }

  /// Get count of tasks by category
  static Map<String, int> get taskCountByCategory {
    final Map<String, int> counts = {};
    for (final category in TaskCategories.all) {
      counts[category.id] = byCategory(category.id).length;
    }
    return counts;
  }

  /// Get all unique cohorts
  static Set<String> get allCohorts {
    final Set<String> cohorts = {};
    for (final task in all) {
      cohorts.addAll(task.cohorts);
    }
    return cohorts;
  }
}
