import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';
import 'payment_success_screen.dart';

/// ការទូទាត់: អាស័យដ្ឋានទទួល, វិធីសាស្ត្រទូទាត់, សង្ខេបការបញ្ជាទិញ
class CheckoutFlowScreen extends StatefulWidget {
  const CheckoutFlowScreen({super.key});

  @override
  State<CheckoutFlowScreen> createState() => _CheckoutFlowScreenState();
}

class _CheckoutFlowScreenState extends State<CheckoutFlowScreen> {
  int _selectedAddressIndex = 0;
  int _selectedPaymentIndex = 0; // 0 Cash, 1 Bank/QR
  final _notesController = TextEditingController();

  static const double _deliveryFee = 3000;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();
    final subtotal = cart.totalPrice;
    final total = subtotal + _deliveryFee;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("ការទូទាត់"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "អាស័យដ្ឋានទទួល",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _addressCard(
              title: "ផ្ទះ សុខ ចន្ថា",
              phone: "012 847 293",
              address: "ផ្លូវ២៨៩, សង្កាត់បឹងកេងកង១, ភ្នំពេញ",
              isSelected: _selectedAddressIndex == 0,
              onTap: () => setState(() => _selectedAddressIndex = 0),
            ),
            const SizedBox(height: 8),
            _addressCard(
              title: "កន្លែងធ្វើការ សុខ ចន្ថា",
              phone: "012 847 293",
              address: "ផ្លូវលេខ៣, សង្កាត់ស្ទឹងមានជ័យ, ភ្នំពេញ",
              isSelected: _selectedAddressIndex == 1,
              onTap: () => setState(() => _selectedAddressIndex = 1),
            ),
            const SizedBox(height: 24),
            const Text(
              "បញ្ជាក់ការបញ្ជាទិញ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "វិធីសាស្ត្រ ទូទាត់",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RadioListTile<int>(
              value: 0,
              groupValue: _selectedPaymentIndex,
              onChanged: (v) => setState(() => _selectedPaymentIndex = v!),
              title: const Text("សាច់ប្រាក់ពេលទទួល"),
              subtitle: const Text("បង់ប្រាក់ពេលទទួលផលិតផល"),
              activeColor: AppColors.primary,
            ),
            RadioListTile<int>(
              value: 1,
              groupValue: _selectedPaymentIndex,
              onChanged: (v) => setState(() => _selectedPaymentIndex = v!),
              title: const Text("ផ្ទេរប្រាក់តាមធនាគារ (ស្កេនQR)"),
              subtitle: const Text("ABA, ACLEDA, Wing, ល.ល."),
              activeColor: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              "ការណែនាំបន្ថែម",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText:
                    "សូមផ្តល់ព័ត៌មានបន្ថែម ឬការណែនាំសម្រាប់អ្នកបញ្ជូន",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "សង្ខេបការបញ្ជាទិញ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.product.name} x ${item.quantity}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      formatPriceRiel(item.totalPrice),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),
            _summaryRow("សរុបរង", subtotal),
            _summaryRow("ថ្លៃដឹកជញ្ជូន", _deliveryFee),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "សរុបទាំងអស់",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatPriceRiel(total),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
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
                  cart.clearCart();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentSuccessScreen(),
                    ),
                  );
                },
                child: const Text("បញ្ជាក់ការបញ្ជាទិញ"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressCard({
    required String title,
    required String phone,
    required String address,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(phone, style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 4),
            Text(
              address,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(formatPriceRiel(amount), style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
