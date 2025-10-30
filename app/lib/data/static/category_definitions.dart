/// Category definitions for tasks and icons
class TaskCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  const TaskCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Static category definitions
class TaskCategories {
  static const health = TaskCategory(
    id: 'health',
    name: 'Health',
    icon: '🏃',
    description: 'Health and wellness activities',
  );

  static const home = TaskCategory(
    id: 'home',
    name: 'Home',
    icon: '🏠',
    description: 'Household chores and responsibilities',
  );

  static const future = TaskCategory(
    id: 'future',
    name: 'Future',
    icon: '🎯',
    description: 'Education and skill development',
  );

  /// All available categories
  static const List<TaskCategory> all = [health, home, future];

  /// Get category by ID
  static TaskCategory? getById(String id) {
    try {
      return all.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get category display name by ID
  static String getNameById(String id) {
    return getById(id)?.name ?? id;
  }

  /// Get category icon by ID
  static String getIconById(String id) {
    return getById(id)?.icon ?? '📋';
  }
}
