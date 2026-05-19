import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaal/features/life_calendar/screens/life_calendar_screen.dart';
import 'package:kaal/core/providers/user_provider.dart';

void main() {
  testWidgets('LifeCalendarGrid has 52 columns', (WidgetTester tester) async {
    final mockUser = UserModel(
      id: 'u1',
      name: 'Tester',
      email: 't@example.com',
      dob: DateTime.now().subtract(const Duration(days: 365 * 25)),
      lifeExpectancyYears: 100,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userProvider.overrideWithValue(AsyncValue.data(mockUser))],
        child: const MaterialApp(home: LifeCalendarScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final gridFinder = find.byType(GridView);
    expect(gridFinder, findsOneWidget);

    final grid = tester.widget<GridView>(gridFinder);
    final delegate = grid.gridDelegate;
    expect(delegate, isA<SliverGridDelegateWithFixedCrossAxisCount>());
    final fixed = delegate as SliverGridDelegateWithFixedCrossAxisCount;
    expect(fixed.crossAxisCount, 52);
  });
}
