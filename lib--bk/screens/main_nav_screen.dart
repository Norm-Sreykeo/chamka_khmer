import 'package:flutter/material.dart' show BottomNavigationBar, BottomNavigationBarItem, BottomNavigationBarType, BuildContext, Center, Color, Colors, Icon, Icons, Scaffold, State, StatefulWidget, StatelessWidget, Text, Widget;
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'categories_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile.dart';           // ← your ProfileScreen file

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

// You can keep this as a placeholder for now
class _CartScreen extends StatelessWidget {
  const _CartScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('កន្ត្រក (កំពុងអភិវឌ្ឍន៍)')),
    );
  }
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),           // index 0 → ទំព័រដើម
    CategoriesScreen(),     // index 1 → ប្រភេទ
    _CartScreen(),          // index 2 → កន្ត្រក
    ProfileScreen(),        // index 3 → គណនី       ← ADD THIS LINE
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF7AA12B),     // green from your app
        unselectedItemColor: const Color(0xFF9FAE8E),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'ទំព័រដើម',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: 'ប្រភេទ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'កន្ត្រក',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'គណនី',
          ),
        ],
      ),
    );
  }
  }