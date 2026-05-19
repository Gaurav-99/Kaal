import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LifeCalendarScreen extends StatelessWidget {
  const LifeCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming 90 years lifespan, 52 weeks a year = 4680 weeks.
    // Let's mock the user is 25 years old.
    final int totalWeeks = 90 * 52;
    final int weeksLived = 25 * 52;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Life in Weeks',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Text(
                'Each square represents one week of a 90-year life.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: GridView.builder(
                  padding: const EdgeInsets.all(24.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 52, // 52 weeks in a row (1 year)
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  itemCount: totalWeeks,
                  itemBuilder: (context, index) {
                    bool isLived = index < weeksLived;
                    bool isCurrent = index == weeksLived;

                    return Container(
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? AppColors.primary
                            : (isLived
                                  ? AppColors.surfaceLight
                                  : AppColors.background),
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.primary
                              : (isLived
                                    ? Colors.transparent
                                    : AppColors.surfaceLight.withAlpha(
                                        (0.3 * 255).round(),
                                      )),
                          width: 0.5,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
