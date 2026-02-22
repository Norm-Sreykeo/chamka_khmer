import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'home/category_list_screen.dart';
import 'cart/cart_screen.dart';
import 'account/profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../core/theme/app_colors.dart';

/// Main shell with bottom nav: ទំព័រដើម, ប្រភេទ, កន្ត្រក, គណនី
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const List<Widget> _tabs = [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
