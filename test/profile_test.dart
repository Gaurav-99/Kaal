import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaal/features/profile/screens/profile_screen.dart';
import 'package:kaal/core/providers/user_provider.dart';

void main() {
  testWidgets('ProfileScreen shows header and edit button', (
    WidgetTester tester,
  ) async {
    final mockUser = UserModel(
      id: 'u1',
      name: 'Test User',
      email: 'test@example.com',
      dob: DateTime(1998, 1, 1),
      lifeExpectancyYears: 90,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userProvider.overrideWithValue(AsyncValue.data(mockUser))],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsWidgets);
    expect(find.text('Edit'), findsOneWidget);
  });
}
