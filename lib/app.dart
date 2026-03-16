import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_screen.dart';
import 'screens/opening/onboarding_screen.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final settings = context.watch<SettingsProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeMode,
      home: auth.currentUser != null
          ? const MainScreen()
          : const OnboardingScreen(),
    );
  }
}
