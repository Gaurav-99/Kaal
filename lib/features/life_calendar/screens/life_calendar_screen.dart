import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/user_provider.dart';

class LifeCalendarScreen extends ConsumerWidget {
  const LifeCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Life in Weeks',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: asyncUser.when(
          data: (user) {
            final int lifeYears = user.lifeExpectancyYears;
            final int totalWeeks = lifeYears * 52;

            // Compute weeks lived based on DOB if available; otherwise estimate from 25 years.
            final now = DateTime.now();
            int weeksLived;
            if (user.dob != null) {
              weeksLived = now.difference(user.dob!).inDays ~/ 7;
            } else {
              weeksLived = 25 * 52; // fallback estimate
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    'Each square represents one week of a $lifeYears-year life.',
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 52, // 52 weeks in a row (1 year)
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                          ),
                      itemCount: totalWeeks,
                      itemBuilder: (context, index) {
                        final bool isLived = index < weeksLived;
                        final bool isCurrent = index == weeksLived;

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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('Error loading life calendar')),
        ),
      ),
    );
  }
}
