import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../../providers/cart_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../payment/checkout_flow_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Widget _buildSummary(
    BuildContext context, {
    required CartProvider cart,
    required bool fullWidthButton,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "តម្លៃ សរុប :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  formatPriceRiel(cart.totalPrice),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: fullWidthButton ? double.infinity : 320,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckoutFlowScreen(),
                    ),
                  );
                },
                child: const Text("បញ្ជាទិញ"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("កន្ត្រក"),
        elevation: 0,
      ),
      body: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "រកអីវ៉ាន់របស់លោកអ្នក នៅទីនេះ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                final horizontalPadding = isWide ? 24.0 : 16.0;

                Widget buildItem(int i) {
                  final item = items[i];
                  final String imageUrl = item.product.imageUrl;
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
                        return Image.memory(
                          bytes,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        );
                      } catch (_) {
                        return const ColoredBox(
                          color: Color(0xFFEFEFEF),
                          child: Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                    }

                    if (isNetworkImage) {
                      return Image.network(
                        imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return Image.asset(
                      assetPath,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: buildImage(),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      formatPriceRiel(item.product.price),
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "x${item.quantity}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                visualDensity: VisualDensity.compact,
                                onPressed: () =>
                                    cart.increaseQty(item.product.id),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    cart.decreaseQty(item.product.id);
                                  } else {
                                    cart.removeFromCart(item.product.id);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final list = ListView.builder(
                  padding: EdgeInsets.all(horizontalPadding),
                  itemCount: items.length,
                  itemBuilder: (_, i) => buildItem(i),
                );

                if (!isWide) {
                  return Column(
                    children: [
                      Expanded(child: list),
                      _buildSummary(context, cart: cart, fullWidthButton: true),
                    ],
                  );
                }

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: constraints.maxHeight,
                              child: list,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Card(
                              margin: EdgeInsets.only(top: horizontalPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _buildSummary(
                                context,
                                cart: cart,
                                fullWidthButton: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
