import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';
import '../../core/theme/app_colors.dart';

/// ចំណូលចិត្ត - 3 ផលិតផល per PDF (favorites with add to cart)
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // Mock: show first 3 products as "favorites"; in real app use a FavoritesProvider
    final favorites = productProvider.products.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("ចំណូលចិត្ត"),
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                "មិនមានផលិតផលចំណូលចិត្ត",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "${favorites.length} ផលិតផល",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...favorites.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ProductCard(product: p),
                  ),
                ),
              ],
            ),
    );
  }
}
