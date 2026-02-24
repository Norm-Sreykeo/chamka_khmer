import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../models/product.dart';
import '../screens/home/product_detail_screen.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/helpers.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    void goToDetail() {
      debugPrint('ProductCard.goToDetail: ${product.id}');
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        ),
      );
    }

    final String imageUrl = product.imageUrl;
    final bool isNetworkImage = imageUrl.startsWith('http');
    final bool isDataImage = imageUrl.startsWith('data:image');
    final String assetPath = imageUrl.startsWith('lib/')
        ? imageUrl
        : 'lib/$imageUrl';

    Widget buildImage() {
      if (isDataImage) {
        final int commaIndex = imageUrl.indexOf(',');
        final String base64Data = commaIndex >= 0
            ? imageUrl.substring(commaIndex + 1)
            : '';
        try {
          final Uint8List bytes = base64Decode(base64Data);
          return Image.memory(bytes, width: double.infinity, fit: BoxFit.cover);
        } catch (_) {
          return const ColoredBox(
            color: Color(0xFFEFEFEF),
            child: Center(
              child: Icon(Icons.broken_image_outlined, color: Colors.grey),
            ),
          );
        }
      }

      if (isNetworkImage) {
        return Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const ColoredBox(
            color: Color(0xFFEFEFEF),
            child: Center(
              child: Icon(Icons.broken_image_outlined, color: Colors.grey),
            ),
          ),
        );
      }

      return Image.asset(assetPath, width: double.infinity, fit: BoxFit.cover);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: goToDetail,
              borderRadius: BorderRadius.circular(14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(aspectRatio: 1.35, child: buildImage()),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: goToDetail,
              borderRadius: BorderRadius.circular(8),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: goToDetail,
                    borderRadius: BorderRadius.circular(8),
                    child: Text(
                      "${formatPriceRiel(product.price)}/1kg",
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: ElevatedButton.icon(
                    onPressed: () {
                      debugPrint('ProductCard.addPressed: ${product.id}');
                      goToDetail();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                    label: const Text(
                      "បន្ថែម",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
