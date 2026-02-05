import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../providers/catalog_provider.dart';
import 'product_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F3EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF77A62E),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'ប្រភេទផលិតផល',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<CatalogProvider>(
        builder: (context, catalog, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: _CategoryChips(
                  categories: catalog.categories,
                  selectedId: catalog.selectedCategoryId,
                  onSelected: catalog.selectCategory,
                ),
              ),
              Expanded(
                child: catalog.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: catalog.filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.78,
                            ),
                        itemBuilder: (context, index) {
                          final product = catalog.filteredProducts[index];
                          return _ProductGridCard(product: product);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<Category> categories;
  final String? selectedId;
  final void Function(String?) onSelected;

  const _CategoryChips({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [Icons.local_florist, Icons.eco, Icons.spa, Icons.grass];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(categories.length, (index) {
        final category = categories[index];
        final isSelected = category.id == selectedId;
        return GestureDetector(
          onTap: () => onSelected(isSelected ? null : category.id),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF77A62E)
                  : const Color(0xFFF1E7CB),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE4D6B0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index % icons.length],
                  size: 18,
                  color: isSelected ? Colors.white : const Color(0xFF8B7B4F),
                ),
                const SizedBox(width: 6),
                Text(
                  category.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF6E7B5A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  final Product product;

  const _ProductGridCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE6D9BD)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.price.toStringAsFixed(0)} រៀល',
                  style: const TextStyle(
                    color: Color(0xFF6E9E2E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7AA12B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product.unit,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
