import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../screens/dashboard_screen.dart';
import '../../screens/onboarding/onboarding_flow_screen.dart';
import '../../screens/onboarding/edit_flow_screen.dart';
import '../../screens/weekly_board_screen.dart';
import '../../screens/settings_screen.dart';
import '../../data/models/checklists.dart';
import 'isar_provider.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // Check if onboarding is needed
      final isar = await ref.read(isarProvider.future);
      final checklists = await isar.checklists.where().count();
      final hasCompletedOnboarding = checklists > 0;

      print('🔀 [Router] Redirect check: path=${state.uri.path}, onboarding=$hasCompletedOnboarding');

      // If no onboarding and not already going to onboarding, redirect
      if (!hasCompletedOnboarding && state.uri.path != '/onboarding') {
        print('🔀 [Router] Redirecting to onboarding');
        return '/onboarding';
      }

      // If onboarding completed and trying to access onboarding, redirect to dashboard
      if (hasCompletedOnboarding && state.uri.path == '/onboarding') {
        print('🔀 [Router] Onboarding already completed, redirecting to dashboard');
        return '/';
      }

      return null; // No redirect
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) {
          final stepParam = state.uri.queryParameters['step'];
          final initialStep = stepParam != null ? int.tryParse(stepParam) ?? 0 : 0;
          return OnboardingFlowScreen(initialStep: initialStep);
        },
      ),
      GoRoute(
        path: '/checklist/:id',
        name: 'weekly-board',
        builder: (context, state) {
          final checklistId = int.parse(state.pathParameters['id']!);
          return WeeklyBoardScreen(checklistId: checklistId);
        },
      ),
      GoRoute(
        path: '/weekly-board',
        name: 'weekly-board-simple',
        builder: (context, state) => const WeeklyBoardScreen(checklistId: 1),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      // Edit routes
      GoRoute(
        path: '/edit/:checklistId/members',
        name: 'edit-members',
        builder: (context, state) {
          final checklistId = int.parse(state.pathParameters['checklistId']!);
          return EditFlowScreen(checklistId: checklistId, initialStep: 1);
        },
      ),
      GoRoute(
        path: '/edit/:checklistId/tasks',
        name: 'edit-tasks',
        builder: (context, state) {
          final checklistId = int.parse(state.pathParameters['checklistId']!);
          return EditFlowScreen(checklistId: checklistId, initialStep: 2);
        },
      ),
      GoRoute(
        path: '/edit/:checklistId/schedule',
        name: 'edit-schedule',
        builder: (context, state) {
          final checklistId = int.parse(state.pathParameters['checklistId']!);
          return EditFlowScreen(checklistId: checklistId, initialStep: 3);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}
