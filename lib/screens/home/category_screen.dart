import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';
import '../../core/theme/app_colors.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryId;
  final String title;
  final String? initialSubCategory;

  const CategoryScreen({
    super.key,
    required this.categoryId,
    required this.title,
    this.initialSubCategory,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _selectedSubCategory;

  @override
  void initState() {
    super.initState();
    _selectedSubCategory = widget.initialSubCategory;
  }

  @override
  Widget build(BuildContext context) {
    final normalizedCategoryId = widget.categoryId.trim().toLowerCase();
    debugPrint(
      'CategoryScreen: categoryId=${widget.categoryId} (normalized=$normalizedCategoryId), title=${widget.title}',
    );

    final provider = Provider.of<ProductProvider>(context);

    final products = provider.getProductsByCategoryAndSubCategory(
      widget.categoryId,
      subCategory: _selectedSubCategory,
    );

    Widget filterPill({
      required String label,
      required String? value,
      required String iconAsset,
    }) {
      final bool selected = _selectedSubCategory == value;
      return InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          setState(() {
            _selectedSubCategory = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : AppColors.textPrimary.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconAsset,
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          if (normalizedCategoryId == 'fruit')
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    filterPill(
                      label: 'ផ្លែឈើផ្អែម',
                      value: 'sweet',
                      iconAsset: 'lib/assets/icons/5.png',
                    ),
                    const SizedBox(width: 10),
                    filterPill(
                      label: 'ផ្លែឈើជូរ',
                      value: 'sour',
                      iconAsset: 'lib/assets/icons/6.png',
                    ),
                    const SizedBox(width: 10),
                    filterPill(
                      label: 'ផ្លែឈើមានទឹក',
                      value: 'juicy',
                      iconAsset: 'lib/assets/icons/7.png',
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
