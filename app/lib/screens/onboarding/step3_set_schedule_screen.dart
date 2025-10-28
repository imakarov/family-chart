import 'package:flutter/material.dart';

/// Screen 3 (Step 3/3): Set schedule for tasks
/// Note: This is a simplified placeholder version
/// Full implementation needs:
/// - List of members with their tasks
/// - Weekday checkboxes for each task
/// - Quick select (Weekdays/Weekend) buttons
/// - Collapsible sections per member
class Step3SetScheduleScreen extends StatelessWidget {
  final VoidCallback onCreateChecklist;

  const Step3SetScheduleScreen({
    super.key,
    required this.onCreateChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100), // Space for progress dots
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
            // Content
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '✨',
                        style: TextStyle(fontSize: 80),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Schedule Configuration',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Full implementation coming soon!\n\nFor now, click "Create Checklist" to continue.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.3),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
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
            onPressed: onCreateChecklist,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A7FCC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
              shadowColor: const Color(0xFF0A7FCC).withOpacity(0.3),
            ),
            child: const Text(
              'Create Checklist',
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
}
