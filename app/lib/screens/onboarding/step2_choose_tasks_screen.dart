import 'package:flutter/material.dart';

/// Screen 2 (Step 2/3): Choose tasks from library
class Step2ChooseTasksScreen extends StatelessWidget {
  final VoidCallback onContinue;

  const Step2ChooseTasksScreen({
    super.key,
    required this.onContinue,
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
                'Choose Tasks',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select tasks for your family members',
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
                    'Step 2 Content\n(Task library with categories)',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A7FCC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
            ],
          ),
        ),
      ),
    );
  }
}
