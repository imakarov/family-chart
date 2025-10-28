import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'welcome_screen.dart';
import 'step1_family_members_screen.dart';
import 'step2_choose_tasks_screen.dart';
import 'step3_set_schedule_screen.dart';
import '../../weekly_board/screens/weekly_board_screen.dart';

/// Main onboarding flow with PageView navigation
class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  ConsumerState<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    // TODO: Save onboarding completion state
    // Navigate to Weekly Board with first checklist
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const WeeklyBoardScreen(checklistId: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with 4 screens
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe, use buttons only
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Screen 0: Welcome
              WelcomeScreen(
                onGetStarted: _goToNextPage,
              ),
              // Screen 1: Family Members
              Step1FamilyMembersScreen(
                onContinue: _goToNextPage,
              ),
              // Screen 2: Choose Tasks
              Step2ChooseTasksScreen(
                onContinue: _goToNextPage,
              ),
              // Screen 3: Set Schedule
              Step3SetScheduleScreen(
                onCreateChecklist: _completeOnboarding,
              ),
            ],
          ),
          // Progress indicators (only show on steps 1-3)
          if (_currentPage > 0)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 0,
              right: 0,
              child: _buildProgressIndicators(),
            ),
          // Step indicator (only show on steps 1-3)
          if (_currentPage > 0)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 20,
              child: _buildStepIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == _currentPage - 1; // -1 because welcome screen doesn't count
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0A7FCC) : const Color(0xFFC7C7CC),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildStepIndicator() {
    if (_currentPage == 0) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Step $_currentPage/3',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF8E8E93),
        ),
      ),
    );
  }
}
