import 'package:flutter/material.dart';

/// Dashboard screen - main screen showing all checklists
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Chart'),
      ),
      body: const Center(
        child: Text('Dashboard - Coming Soon'),
      ),
    );
  }
}
