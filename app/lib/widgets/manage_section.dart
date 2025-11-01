import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Section with buttons to manage checklist (Edit Members, Tasks, Schedule)
class ManageSection extends StatelessWidget {
  final int checklistId; // Checklist ID to edit

  const ManageSection({
    super.key,
    this.checklistId = 1, // Default to checklist ID 1
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildManageButton(
          context,
          icon: '👥',
          text: 'Edit Family Members',
          onTap: () {
            // Navigate to edit members flow
            context.push('/edit/$checklistId/members');
          },
        ),
        const SizedBox(height: 12),
        _buildManageButton(
          context,
          icon: '✅',
          text: 'Edit Tasks',
          onTap: () {
            // Navigate to edit tasks flow
            context.push('/edit/$checklistId/tasks');
          },
        ),
        const SizedBox(height: 12),
        _buildManageButton(
          context,
          icon: '📅',
          text: 'Edit Schedule',
          onTap: () {
            // Navigate to edit schedule flow
            context.push('/edit/$checklistId/schedule');
          },
        ),
      ],
    );
  }

  Widget _buildManageButton(
    BuildContext context, {
    required String icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5E5EA),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            const Text(
              '›',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
