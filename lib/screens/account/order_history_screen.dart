import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';

/// ប្រវត្តិការបញ្ជាទិញ - mock orders per PDF (ORD-001, ORD-002, ORD-003)
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  static final List<Map<String, dynamic>> _mockOrders = [
    {
      "id": "ORD-001",
      "status": "បានដឹកជញ្ជូន",
      "date": "២៨ ធ្នូ ២០២៥",
      "total": 45000.0,
      "items": "ស្វាយ x2, ល្ហុង x3, ចេក x3",
    },
    {
      "id": "ORD-002",
      "status": "កំពុងដឹកជញ្ជូន",
      "date": "២៨ ធ្នូ ២០២៥",
      "total": 32000.0,
      "items": "ស្វាយ x2, ល្ហុង x3, ចេក x3",
    },
    {
      "id": "ORD-003",
      "status": "កំពុងរៀបចំ",
      "date": "២៨ ធ្នូ ២០២៥",
      "total": 25000.0,
      "items": "ស្វាយ x2, ល្ហុង x1",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("ប្រវត្តិការបញ្ជាទិញ"),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockOrders.length,
        itemBuilder: (_, i) {
          final o = _mockOrders[i];
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
                        o["id"] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          o["status"] as String,
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
                    o["date"] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    o["items"] as String,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatPriceRiel(o["total"] as double),
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
