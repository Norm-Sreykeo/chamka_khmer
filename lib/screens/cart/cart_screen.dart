import 'package:flutter/material.dart';
import '../payment/payment_method_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // temporary mock cart items
    final cartItems = [
      {"name": "ស្វាយ", "price": 6000, "qty": 2},
      {"name": "ការ៉ុត", "price": 3000, "qty": 1},
    ];

    int total = cartItems.fold(
        0, (sum, item) => sum + (item["price"] as int) * (item["qty"] as int));

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (_, i) {
                final item = cartItems[i];

                return ListTile(
                  leading: const Icon(Icons.shopping_basket),
                  title: Text(item["name"].toString()),
                  subtitle: Text("${item["price"]} ៛"),
                  trailing: Text("x${item["qty"]}"),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(fontSize: 18)),
                    Text(
                      "$total ៛",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7FBF5F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentMethodScreen(),
                        ),
                      );
                    },
                    child: const Text("Checkout"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
