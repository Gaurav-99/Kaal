import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Time is your most\nvaluable resource.",
      "subtitle": "Yet, it's the one we often take for granted.",
    },
    {
      "title": "You are living a finite\nnumber of weeks.",
      "subtitle": "Visualizing your life brings clarity to what matters.",
    },
    {
      "title": "Awareness creates\nintention.",
      "subtitle": "Stop drifting. Start choosing how you spend your days.",
    },
    {
      "title": "Kaal helps you see\nyour life differently.",
      "subtitle": "A calm, philosophical approach to intentional living.",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(gradient: AppColors.cosmicGradient),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // An abstract circle for cinematic feel
                            Center(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: _currentPage == index ? 200 : 150,
                                height: _currentPage == index ? 200 : 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      AppColors.primary.withAlpha(
                                        (0.5 * 255).round(),
                                      ),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primary.withAlpha(
                                          (0.3 * 255).round(),
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            Text(
                              _onboardingData[index]["title"]!,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    height: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _onboardingData[index]["subtitle"]!,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Controls
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Indicators
                      Row(
                        children: List.generate(
                          _onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 4,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? AppColors.primary
                                  : AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      // Next / Start Button
                      GestureDetector(
                        onTap: () {
                          if (_currentPage == _onboardingData.length - 1) {
                            context.go('/auth');
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary.withAlpha(
                                (0.5 * 255).round(),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            _currentPage == _onboardingData.length - 1
                                ? 'Begin'
                                : 'Next',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
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
