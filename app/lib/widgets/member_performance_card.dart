import 'package:flutter/material.dart';

/// Card showing member's monthly task performance
class MemberPerformanceCard extends StatelessWidget {
  final String memberName;
  final String memberAvatar;

  const MemberPerformanceCard({
    super.key,
    required this.memberName,
    required this.memberAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Member header
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF2F2F7),
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  memberAvatar,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Text(
                  memberName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Text(
                  '›',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Best Tasks section
          _buildTasksGroup(
            title: '✅ Best Tasks',
            tasks: _getMockBestTasks(),
          ),
          const SizedBox(height: 20),

          // Needs Attention section
          _buildTasksGroup(
            title: '⚠️ Needs Attention',
            tasks: _getMockAttentionTasks(),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksGroup({
    required String title,
    required List<TaskProgress> tasks,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8E8E93),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        ...tasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildTaskItem(task),
            )),
      ],
    );
  }

  Widget _buildTaskItem(TaskProgress task) {
    return Row(
      children: [
        // Task icon with background
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFE5E5EA),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              task.icon,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Task info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F7),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: task.progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getProgressColor(task.progress),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${(task.progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E8E93),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.90) {
      return const Color(0xFF34C759); // Excellent - green
    } else if (progress >= 0.75) {
      return const Color(0xFFA4D96C); // Good - light green
    } else if (progress >= 0.50) {
      return const Color(0xFFFF9500); // Warning - orange
    } else if (progress >= 0.25) {
      return const Color(0xFFFF6B6B); // Poor - red-orange
    } else {
      return const Color(0xFFFF3B30); // Bad - red
    }
  }

  List<TaskProgress> _getMockBestTasks() {
    if (memberName == 'Kate') {
      return [
        TaskProgress(icon: '🪥', name: 'Brush Teeth', progress: 0.95),
        TaskProgress(icon: '🛏️', name: 'Make Bed', progress: 0.90),
      ];
    } else {
      return [
        TaskProgress(icon: '🗑️', name: 'Take Out Trash', progress: 1.0),
        TaskProgress(icon: '🚗', name: 'Drive Kids', progress: 0.85),
      ];
    }
  }

  List<TaskProgress> _getMockAttentionTasks() {
    if (memberName == 'Kate') {
      return [
        TaskProgress(icon: '📚', name: 'Homework', progress: 0.40),
        TaskProgress(icon: '🐕', name: 'Walk Dog', progress: 0.50),
      ];
    } else {
      return [
        TaskProgress(icon: '🍽️', name: 'Do Dishes', progress: 0.45),
        TaskProgress(icon: '🧹', name: 'Vacuum House', progress: 0.55),
      ];
    }
  }
}

class TaskProgress {
  final String icon;
  final String name;
  final double progress;

  TaskProgress({
    required this.icon,
    required this.name,
    required this.progress,
  });
}
