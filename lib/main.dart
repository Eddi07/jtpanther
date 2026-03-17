import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/supabase_constants.dart';
import 'routes/app_router.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  runApp(const JTPantherApp());
}

class JTPantherApp extends StatelessWidget {
  const JTPantherApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: "JTPanther",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );

  }
}