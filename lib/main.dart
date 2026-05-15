import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase (Mock keys for setup, replace with real later)
  /*
  await Supabase.initialize(
    url: 'https://YOUR_SUPABASE_URL.supabase.co',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  */

  runApp(
    const ProviderScope(
      child: KaalApp(),
    ),
  );
}

class KaalApp extends ConsumerWidget {
  const KaalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Kaal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
