import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class QuantitySelector extends StatelessWidget {
  final int value;
  final Function(int) onChanged;

  const QuantitySelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _circleButton(
          icon: Icons.remove,
          backgroundColor: const Color(0xFFEAEAEA),
          iconColor: AppColors.textPrimary,
          onTap: () {
            if (value > 1) onChanged(value - 1);
          },
        ),
        const Spacer(),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        _circleButton(
          icon: Icons.add,
          backgroundColor: AppColors.primary,
          iconColor: Colors.white,
          onTap: () {
            onChanged(value + 1);
          },
        ),
      ],
    );
  }

  Widget _circleButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 54,
      height: 54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: IconButton(
          icon: Icon(icon, color: iconColor, size: 28),
          onPressed: onTap,
        ),
      ),
    );
  }
}
