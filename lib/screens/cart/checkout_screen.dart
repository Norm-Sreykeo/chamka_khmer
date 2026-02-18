import 'package:flutter/material.dart';
import '../payment/payment_method_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const ListTile(
              title: Text("Delivery Address"),
              subtitle: Text("Phnom Penh, Cambodia"),
              leading: Icon(Icons.location_on),
            ),

            const Divider(),

            const ListTile(
              title: Text("Delivery Time"),
              subtitle: Text("30 - 45 minutes"),
              leading: Icon(Icons.timer),
            ),

            const Spacer(),

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
                        builder: (_) => const PaymentMethodScreen()),
                  );
                },
                child: const Text("Proceed to Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
