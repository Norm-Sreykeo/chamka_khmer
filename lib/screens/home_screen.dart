import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../providers/catalog_provider.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5ED),
      body: SafeArea(
        child: Consumer<CatalogProvider>(
          builder: (context, catalog, _) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF7AA12B),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(26),
                            bottomRight: Radius.circular(26),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/images/img1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ចម្ការខ្មែរ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'ផ្លែឈើស្រស់ ពីចម្ការខ្មែរ',
                                        style: TextStyle(
                                          color: Color(0xFFF1F6E8),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'ស្វែងផ្លែឈើ និង បន្លែ..',
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFF9E6B3D),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF9E6B3D),
                                    fontSize: 13,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFF1A567),
                                ),
                              ),
                              child: const Text(
                                '🌴 ស្វែងរក ផ្លែឈើ និង បន្លែស្រស់ 🌴',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFB86B2A),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'ប្រភេទផលិតផល',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _CategoryChips(
                              categories: catalog.categories,
                              selectedId: catalog.selectedCategoryId,
                              onSelected: catalog.selectCategory,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'ផលិតផលថ្មីៗ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (catalog.isLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = catalog.filteredProducts[index];
                        return _ProductCard(product: product);
                      }, childCount: catalog.filteredProducts.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.74,
                          ),
                    ),
                  ),
              ],
            );
          },
        ),
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
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedId;
          return GestureDetector(
            onTap: () => onSelected(isSelected ? null : category.id),
            child: Container(
              width: 78,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFFE7A1)
                    : const Color(0xFFFFF1C4),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 34,
                    height: 34,
                    child: Image.asset(category.imagePath, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 10,
                      color: const Color(0xFF6E7B5A),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: categories.length,
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEFE3C9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.price.toStringAsFixed(0)} រៀល',
                  style: const TextStyle(
                    color: Color(0xFF6E9E2E),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
