import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/quantity_selector.dart';
import '../../widgets/custom_button.dart';
import '../../core/theme/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3EA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(product.name),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(width: 10)
        ],
      ),
      body: Column(
        children: [
          /// 🖼 Product Image
          Container(
            margin: const EdgeInsets.all(16),
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 📄 Details
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 6),
                  Text("⭐ ${product.rating}"),

                  const SizedBox(height: 15),
                  const Text("ពិពណ៌នា",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(product.description ?? ""),

                  const Spacer(),

                  /// Quantity
                  QuantitySelector(
                    value: qty,
                    onChanged: (v) => setState(() => qty = v),
                  ),

                  const SizedBox(height: 10),

                  /// Price + Add to Cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price * qty}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      CustomButton(
                        text: "ដាក់ក្នុងកន្ត្រក",
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
