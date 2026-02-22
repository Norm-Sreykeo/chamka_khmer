import 'package:flutter/material.dart';
import '../models/category.dart' as model;
import '../screens/home/category_screen.dart';
import '../core/theme/app_colors.dart';

/// Figma-style category card: light yellow square, icon on top, label below. Used in horizontal row.
class CategoryGridCard extends StatelessWidget {
  final model.Category category;

  const CategoryGridCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (category.iconAsset != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  category.iconAsset!,
                  width: 44,
                  height: 44,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    category.icon ?? Icons.category,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
              )
            else
              Icon(
                category.icon ?? Icons.category,
                size: 40,
                color: AppColors.primary,
              ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
