import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  String selected = "ABA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Method")),
      body: Column(
        children: [

          RadioListTile(
            value: "ABA",
            groupValue: selected,
            title: const Text("ABA Pay"),
            onChanged: (v) => setState(() => selected = v!),
          ),

          RadioListTile(
            value: "Wing",
            groupValue: selected,
            title: const Text("Wing"),
            onChanged: (v) => setState(() => selected = v!),
          ),

          RadioListTile(
            value: "Cash",
            groupValue: selected,
            title: const Text("Cash on Delivery"),
            onChanged: (v) => setState(() => selected = v!),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7FBF5F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PaymentSuccessScreen()),
                  );
                },
                child: const Text("Confirm Payment"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
