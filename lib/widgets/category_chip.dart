import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../screens/home/category_screen.dart';
import '../core/theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final Category category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryScreen(
                categoryId: category.id,
                title: category.name,
              ),
            ),
          );
        },
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: category.color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              if (category.icon != null)
                Icon(category.icon, color: Colors.white, size: 18),
              if (category.icon != null)
                const SizedBox(width: 6),
              Text(
                category.name,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
