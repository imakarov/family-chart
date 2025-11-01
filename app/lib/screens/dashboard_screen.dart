import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../widgets/checklist_card.dart';
import '../widgets/member_performance_card.dart';
import '../widgets/manage_section.dart';
import '../widgets/app_menu_drawer.dart';
import '../core/providers/isar_provider.dart';
import '../data/models/checklists.dart';

/// Dashboard screen - main screen after onboarding
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _getWeekInfo() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final formatter = DateFormat('MMM d');
    return 'Week of ${formatter.format(startOfWeek)}-${endOfWeek.day}';
  }

  Future<int?> _getActiveChecklistId(WidgetRef ref) async {
    final isar = await ref.read(isarProvider.future);
    final checklists = await isar.checklists.where().findAll();
    return checklists.isNotEmpty ? checklists.first.checklistId : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int?>(
      future: _getActiveChecklistId(ref),
      builder: (context, snapshot) {
        final checklistId = snapshot.data ?? 1; // Default to 1 if no checklist found

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F5F7),
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, size: 28, color: Color(0xFF0C7FCC)),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: null,
            toolbarHeight: 56,
          ),
          drawer: AppMenuDrawer(
            checklistId: checklistId,
            showDashboardOption: false, // Hide Dashboard option when on Dashboard
          ),
          body: SafeArea(
        top: false, // AppBar already handles top safe area
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Family Chart 👋',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getWeekInfo(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Current Checklist Card
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ChecklistCard(),
              ),
            ),

            // Month Performance Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Row(
                  children: [
                    const Text(
                      '📈',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Month Performance',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Member Performance Cards
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    MemberPerformanceCard(
                      memberName: 'Kate',
                      memberAvatar: '👧',
                    ),
                    SizedBox(height: 16),
                    MemberPerformanceCard(
                      memberName: 'Dad',
                      memberAvatar: '👨',
                    ),
                  ],
                ),
              ),
            ),

            // Manage Checklist Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    const Text(
                      '✏️',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Manage Checklist',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Manage Buttons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                child: ManageSection(checklistId: checklistId),
              ),
            ),
          ],
        ),
      ),
        );
      },
    );
  }
}
