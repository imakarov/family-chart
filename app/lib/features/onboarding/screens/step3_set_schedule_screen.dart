import 'package:flutter/material.dart';

/// Screen 3 (Step 3/3): Set schedule for tasks
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose which days to do each task',
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF8E8E93),
                ),
              ),
              const SizedBox(height: 32),
              // Content placeholder
              Expanded(
                child: Center(
                  child: Text(
                    'Step 3 Content\n(Schedule configuration)',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Create Checklist Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onCreateChecklist,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A7FCC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
