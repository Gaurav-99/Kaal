import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kaal/core/routes/app_router.dart';

void main() {
  test('appRouter is a GoRouter instance', () {
    expect(appRouter, isA<GoRouter>());
  });
}
