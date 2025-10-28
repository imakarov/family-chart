import 'package:flutter/material.dart';

/// Onboarding screen - first-time user experience
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: const Center(
        child: Text('Onboarding - Coming Soon'),
      ),
    );
  }
}
