import 'package:flutter/material.dart';
import '../screens/opening/splash_screen.dart';
import '../screens/opening/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/cart/cart_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const home = '/home';
  static const cart = '/cart';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    login: (_) => const LoginScreen(),
    home: (_) => const HomeScreen(),
    cart: (_) => const CartScreen(),
  };
}
