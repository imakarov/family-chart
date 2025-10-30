import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Screen 0: Welcome screen matching HTML prototype design
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Spacer(flex: 3),
              // Hero section with icon and title
              _buildHeroSection(),
              const SizedBox(height: 40),
              // Steps card
              _buildStepsCard(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 34, top: 8),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A7FCC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Get Started',
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

  Widget _buildHeroSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Lottie animation as background layer - larger size
        Positioned(
          top: -50,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 300,
            child: Lottie.asset(
              'assets/animations/stars_points_extracted.json',
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),
        ),
        // Content on top
        Column(
          children: [
            // Family icon on top with blue gradient
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0A7FCC), // Main blue
                    Color(0xFF0B6FBB), // Slightly darker blue
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Image.asset(
                'assets/images/family_icon.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Title (two lines)
            const Text(
              'Welcome to\nFamily Checklist',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.black,
                height: 1.2,
                letterSpacing: -1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title
          const Text(
            '3 Easy Steps to Start',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0A7FCC),
            ),
          ),
          const SizedBox(height: 16),
          // Steps
          _buildStep('1', 'Add Family Members', 'Create profiles for everyone'),
          const Divider(height: 1, color: Color(0xFFF2F2F7)),
          _buildStep('2', 'Choose Tasks', 'Select activities for each member'),
          const Divider(height: 1, color: Color(0xFFF2F2F7)),
          _buildStep(
            '3',
            'Set Schedule',
            'Pick days for each task',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    String number,
    String title,
    String description, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: number == '1' ? 0 : 12,
        bottom: isLast ? 0 : 12,
      ),
      child: Row(
        children: [
          // Number circle
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF0A7FCC),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
