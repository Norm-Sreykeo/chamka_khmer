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
        _button(Icons.remove, () {
          if (value > 1) onChanged(value - 1);
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        _button(Icons.add, () {
          onChanged(value + 1);
        }),
      ],
    );
  }

  Widget _button(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}
