import 'dart:developer' as developer;

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  /// Initializes Supabase if `SUPABASE_URL` and `SUPABASE_ANON_KEY`
  /// are provided via `--dart-define` (recommended) or other compile-time
  /// environment. If not provided, initialization is skipped safely.
  static Future<void> initialize() async {
    const url = String.fromEnvironment('SUPABASE_URL');
    const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    if (url.isEmpty || anonKey.isEmpty) {
      developer.log(
        'Supabase not initialized: SUPABASE_URL/SUPABASE_ANON_KEY not provided via --dart-define',
        name: 'SupabaseService',
      );
      return;
    }

    try {
      await Supabase.initialize(url: url, anonKey: anonKey);
      developer.log('Supabase initialized', name: 'SupabaseService');
    } catch (e, st) {
      developer.log(
        'Supabase init failed: $e',
        error: e,
        stackTrace: st,
        name: 'SupabaseService',
      );
    }
  }
}
