import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../../providers/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$d-$m-$y';
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("ប្រវត្តិការបញ្ជាទិញ"),
        elevation: 0,
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                "មិនមានប្រវត្តិការបញ្ជាទិញ",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, i) {
                final o = orders[i];
                final itemsText = o.items
                    .map((it) => "${it.product.name} x${it.quantity}")
                    .join(", ");

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              o.id,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                o.status,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatDate(o.date),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(itemsText, style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatPriceRiel(o.totalAmount),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("មើលលំអិត"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
