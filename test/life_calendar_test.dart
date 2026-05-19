import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:kaal/features/life_calendar/screens/life_calendar_screen.dart';

void main() {
  testWidgets('LifeCalendarGrid has 52 columns', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LifeCalendarScreen()));
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
