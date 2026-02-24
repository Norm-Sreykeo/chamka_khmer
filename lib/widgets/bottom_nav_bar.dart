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

  static const List<String> _labels = ["ទំព័រដើម", "ប្រភេទ", "កន្ត្រក", "គណនី"];

  static const List<IconData> _icons = [
    Icons.home,
    Icons.grid_view,
    Icons.shopping_cart,
    Icons.person,
  ];

  BottomNavigationBarItem _item(int index) {
    final icon = _icons[index];
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Icon(icon, size: 24),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 24, color: AppColors.primary),
        ),
      ),
      label: _labels[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColors.navBarBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        showUnselectedLabels: true,
        onTap: onTap,
        items: List.generate(_labels.length, _item),
      ),
    );
  }
}
