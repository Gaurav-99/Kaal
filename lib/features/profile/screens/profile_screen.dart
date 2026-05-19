import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/providers/user_data_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);
    final userData = ref.watch(userDataProvider);

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
                      onPressed: () async {
                        await showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                              ),
                              child: _EditProfileForm(user: user),
                            );
                          },
                        );
                        // After modal closes, refresh provider to show updated data.
                        ref.invalidate(userProvider);
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

class _EditProfileForm extends ConsumerStatefulWidget {
  final UserModel user;
  const _EditProfileForm({required this.user});

  @override
  ConsumerState<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<_EditProfileForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _dob = widget.user.dob;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Profile',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  _dob != null
                      ? _dob!.toLocal().toIso8601String().split('T').first
                      : 'DOB: Unknown',
                ),
              ),
              TextButton(onPressed: _pickDob, child: const Text('Pick DOB')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initial = _dob ?? DateTime(now.year - 25);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _dob = picked);
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    final updated = UserModel(
      id: widget.user.id.isNotEmpty ? widget.user.id : 'anon',
      name: name.isNotEmpty ? name : widget.user.name,
      email: email.isNotEmpty ? email : widget.user.email,
      dob: _dob,
      lifeExpectancyYears: widget.user.lifeExpectancyYears, // Keep original in UserModel, UI uses UserData
    );

    await saveUser(updated);

    // Sync the updated DOB into the dynamic UserDataNotifier
    ref.read(userDataProvider.notifier).updateUserData(
      ref.read(userDataProvider).copyWith(dob: _dob),
    );

    // Dismiss sheet
    if (mounted) Navigator.of(context).pop();
  }
}
