import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: asyncUser.when(
            data: (user) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.surfaceLight,
                      child: Text(user.name.isNotEmpty ? user.name[0] : '?'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: open edit profile flow
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Life Details',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 12),
                Card(
                  color: AppColors.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date of Birth: ${user.dob != null ? user.dob!.toLocal().toIso8601String().split('T').first : 'Unknown'}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Estimated life expectancy: ${user.lifeExpectancyYears} years',
                        ),
                        const SizedBox(height: 8),
                        Text('Years lived (approx): ${_yearsLived(user)}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error loading profile')),
          ),
        ),
      ),
    );
  }

  int _yearsLived(UserModel u) {
    if (u.dob == null) return 0;
    final now = DateTime.now();
    final years =
        now.year -
        u.dob!.year -
        (now.month < u.dob!.month ||
                (now.month == u.dob!.month && now.day < u.dob!.day)
            ? 1
            : 0);
    return years;
  }
}
