import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'បញ្ជាទិញប្រវត្តិ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _OrderCard(
            orderId: 'ORD-001',
            status: 'បានបញ្ជាក់រួចរាល់',
            statusColor: Colors.green,
            total: '45,000',
            items: [
              'ផ្លែឈើ x2',
              'បន្លែ x3',
              'សាច់ x3',
            ],
            showDetailsButton: true,
            showCancelButton: true,
          ),
          _OrderCard(
            orderId: 'ORD-002',
            status: 'កំពុងដំណើរការ',
            statusColor: Colors.blue,
            total: '32,000',
            items: [
              'ផ្លែឈើ x2',
              'បន្លែ x3',
              'សាច់ x3',
            ],
            showDetailsButton: false,
            showCancelButton: false,
          ),
          _OrderCard(
            orderId: 'ORD-003',
            status: 'កំពុងរង់ចាំ',
            statusColor: Colors.orange,
            total: '25,000',
            items: [
              'ផ្លែឈើ x2',
              'បន្លែ x1',
            ],
            showDetailsButton: false,
            showCancelButton: false,
          ),
          // Add more orders here...
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final Color statusColor;
  final String total;
  final List<String> items;
  final bool showDetailsButton;
  final bool showCancelButton;

  const _OrderCard({
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.total,
    required this.items,
    this.showDetailsButton = false,
    this.showCancelButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID + Status + Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined, size: 20, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      orderId,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'សរុបទឹកប្រាក់',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  '$totalរៀល',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Items list
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 15),
                  ),
                )),

            const SizedBox(height: 16),

            // Action buttons
            if (showDetailsButton || showCancelButton)
              Row(
                children: [
                  if (showDetailsButton)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Navigate to order details
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('មើលលម្អិតការបញ្ជាទិញ')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('មើលលម្អិត'),
                      ),
                    ),
                  if (showDetailsButton && showCancelButton) const SizedBox(width: 12),
                  if (showCancelButton)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Cancel order logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('បានបោះបង់ការបញ្ជាទិញ')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('បោះបង់'),
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