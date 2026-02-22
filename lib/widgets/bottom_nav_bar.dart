import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<String> _labels = [
    "ទំព័រដើម",
    "ប្រភេទ",
    "កន្ត្រក",
    "គណនី",
  ];

  static const List<IconData> _icons = [
    Icons.home,
    Icons.grid_view,
    Icons.shopping_cart,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBarBackground,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColors.navBarBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        items: List.generate(
        _labels.length,
        (i) => BottomNavigationBarItem(
          icon: Icon(_icons[i]),
          label: _labels[i],
        ),
      ),
      ),
    );
  }
}
