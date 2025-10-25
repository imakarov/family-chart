import 'package:flutter/material.dart';

/// Weekly Board screen - main checklist table view
class WeeklyBoardScreen extends StatelessWidget {
  final String checklistId;

  const WeeklyBoardScreen({
    super.key,
    required this.checklistId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Board'),
      ),
      body: Center(
        child: Text('Weekly Board for checklist: $checklistId\n\nComing Soon'),
      ),
    );
  }
}
