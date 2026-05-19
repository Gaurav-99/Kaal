import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/user_provider.dart';
import '../../life_calendar/screens/life_calendar_screen.dart';
import '../../profile/screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const LifeCalendarScreen(),
    const Center(child: Text("Reflection")),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.surfaceLight.withAlpha((0.5 * 255).round()),
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppColors.background,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendarWeek),
              label: 'Life',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.feather),
              label: 'Reflect',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userAstronaut),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        final int expectedLifespan = user.lifeExpectancyYears;
        final int totalWeeks = expectedLifespan * 52;
        
        int weeksLived = 0;
        if (user.dob != null) {
          weeksLived = DateTime.now().difference(user.dob!).inDays ~/ 7;
        }
        
        final double percentLived = totalWeeks > 0 ? (weeksLived / totalWeeks).clamp(0.0, 1.0) : 0.0;
        final int percentDisplay = (percentLived * 100).round();
        final int weekendsLeft = (totalWeeks - weeksLived).clamp(0, totalWeeks);

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          user.name.isNotEmpty ? user.name : 'Seeker.',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceLight,
                        shape: BoxShape.circle,
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.bell,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Life Progress Widget
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(
                                (0.1 * 255).round(),
                              ),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 4.0,
                        percent: percentLived,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: AppColors.surfaceLight,
                        linearGradient: AppColors.primaryGradient,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$percentDisplay%',
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'of expected life',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Today's Insight
                Text(
                  'Insight',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.surfaceLight, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.lightbulb,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'You have approximately $weekendsLeft weekends left. Make them count.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Active Countdowns
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active Countdowns',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCountdownCard(
                  context,
                  'Parents\' Anniversary',
                  'in 14 days',
                  const FaIcon(
                    FontAwesomeIcons.heart,
                    color: AppColors.accent,
                    size: 20,
                  ),
                  0.8,
                ),
                const SizedBox(height: 12),
                _buildCountdownCard(
                  context,
                  'Next Full Moon',
                  'in 5 days',
                  const FaIcon(
                    FontAwesomeIcons.moon,
                    color: AppColors.accent,
                    size: 20,
                  ),
                  0.9,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const Center(child: Text('Error loading user data')),
    );
  }

  Widget _buildCountdownCard(
    BuildContext context,
    String title,
    String subtitle,
    Widget iconWidget,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: iconWidget,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 2.0,
            percent: progress,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: AppColors.surfaceLight,
            progressColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
