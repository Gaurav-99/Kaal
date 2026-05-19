import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaal/core/theme/app_theme.dart';
import 'package:kaal/core/constants/app_colors.dart';

void main() {
  testWidgets('AppTheme.darkTheme builds and uses AppColors.primary', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.darkTheme, home: const SizedBox()),
    );
    final context = tester.element(find.byType(SizedBox));
    final theme = Theme.of(context);
    expect(theme.colorScheme.primary, AppColors.primary);
  });
}
