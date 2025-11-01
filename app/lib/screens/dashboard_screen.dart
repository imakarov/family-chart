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
import '../data/models/users.dart';
import '../data/models/tasks.dart';
import '../data/models/user_tasks.dart';
import '../data/repositories/users_repository.dart';
import '../data/repositories/tasks_repository.dart';
import '../data/repositories/user_tasks_repository.dart';
import '../core/services/pdf_service.dart';
import '../core/utils/date_utils.dart' as app_date_utils;

/// Dashboard screen - main screen after onboarding
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  // Handle print current week from menu
  Future<void> _handlePrintCurrentWeek(int checklistId) async {
    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Generating PDF...'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      final now = DateTime.now();
      final weekNumber = app_date_utils.DateUtils.getWeekNumber(now);
      final weekYear = app_date_utils.DateUtils.getWeekYear(now);

      final users = await ref.read(usersRepositoryProvider).getAllUsers();
      final tasks = await ref.read(tasksRepositoryProvider).getAllTasks();
      final userTasks = await ref.read(userTasksRepositoryProvider).getUserTasksByChecklistId(checklistId);

      final pdfService = PdfService();
      final pdfBytes = await pdfService.generateWeeklyBoardPdf(
        weekNumber: weekNumber,
        weekYear: weekYear,
        users: users,
        tasks: tasks,
        userTasks: userTasks,
      );

      await pdfService.printDocument(pdfBytes);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate PDF: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  // Handle print next week from menu
  Future<void> _handlePrintNextWeek(int checklistId) async {
    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Generating PDF...'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      final now = DateTime.now();
      final weekNumber = app_date_utils.DateUtils.getWeekNumber(now);
      final weekYear = app_date_utils.DateUtils.getWeekYear(now);

      final users = await ref.read(usersRepositoryProvider).getAllUsers();
      final tasks = await ref.read(tasksRepositoryProvider).getAllTasks();
      final userTasks = await ref.read(userTasksRepositoryProvider).getUserTasksByChecklistId(checklistId);

      final pdfService = PdfService();
      final pdfBytes = await pdfService.generateWeeklyBoardPdf(
        weekNumber: weekNumber + 1,
        weekYear: weekYear,
        users: users,
        tasks: tasks,
        userTasks: userTasks,
      );

      await pdfService.printDocument(pdfBytes);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate PDF: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  // Handle print next 3 weeks from menu
  Future<void> _handlePrintNext3Weeks(int checklistId) async {
    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Generating 3 weeks PDF...'),
            duration: Duration(seconds: 3),
          ),
        );
      }

      final now = DateTime.now();
      final weekNumber = app_date_utils.DateUtils.getWeekNumber(now);
      final weekYear = app_date_utils.DateUtils.getWeekYear(now);

      final users = await ref.read(usersRepositoryProvider).getAllUsers();
      final tasks = await ref.read(tasksRepositoryProvider).getAllTasks();
      final userTasks = await ref.read(userTasksRepositoryProvider).getUserTasksByChecklistId(checklistId);

      final pdfService = PdfService();
      final pdfBytes = await pdfService.generateMultipleWeeksPdf(
        startWeekNumber: weekNumber + 1,  // Start from next week
        startWeekYear: weekYear,
        numberOfWeeks: 3,
        users: users,
        tasks: tasks,
        userTasks: userTasks,
      );

      await pdfService.printDocument(pdfBytes);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate PDF: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

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
  Widget build(BuildContext context) {
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
            onPrintCurrentWeek: () => _handlePrintCurrentWeek(checklistId),
            onPrintNextWeek: () => _handlePrintNextWeek(checklistId),
            onPrintNext3Weeks: () => _handlePrintNext3Weeks(checklistId),
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
