import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/auth_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../account/address_screen.dart';
import '../auth/login_screen.dart';
import 'payment_success_screen.dart';

/// ការទូទាត់: អាស័យដ្ឋានទទួល, វិធីសាស្ត្រទូទាត់, សង្ខេបការបញ្ជាទិញ
class CheckoutFlowScreen extends StatefulWidget {
  const CheckoutFlowScreen({super.key});

  @override
  State<CheckoutFlowScreen> createState() => _CheckoutFlowScreenState();
}

class _CheckoutFlowScreenState extends State<CheckoutFlowScreen> {
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
    final orders = context.read<OrderProvider>();
    final auth = context.watch<AuthProvider>();
    final user = auth.user;
    final items = cart.items.values.toList();
    final subtotal = cart.totalPrice;
    final total = subtotal + _deliveryFee;

    final String savedAddress = (user?['address'] ?? '').toString().trim();
    final bool hasAddress = savedAddress.isNotEmpty;
    final selectedPaymentMethod = _selectedPaymentIndex == 0
        ? "សាច់ប្រាក់ពេលទទួល"
        : "ផ្ទេរប្រាក់តាមធនាគារ (ស្កេនQR)";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("ការទូទាត់"),
        elevation: 0,
      ),
      body: user == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "សូមចូលគណនីជាមុនសិន",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text("ចូលគណនី"),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
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
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddressScreen()),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: hasAddress
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          width: hasAddress ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: hasAddress
                                ? AppColors.primary
                                : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hasAddress
                                      ? "អាស័យដ្ឋានរបស់អ្នក"
                                      : "សូមបញ្ចូលអាស័យដ្ឋាន",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hasAddress
                                      ? savedAddress
                                      : "ចុចទីនេះដើម្បីបន្ថែមអាស័យដ្ឋាន",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.edit_outlined, color: Colors.grey),
                        ],
                      ),
                    ),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  RadioListTile<int>(
                    value: 0,
                    groupValue: _selectedPaymentIndex,
                    onChanged: (v) =>
                        setState(() => _selectedPaymentIndex = v!),
                    title: const Text("សាច់ប្រាក់ពេលទទួល"),
                    subtitle: const Text("បង់ប្រាក់ពេលទទួលផលិតផល"),
                    activeColor: AppColors.primary,
                  ),
                  RadioListTile<int>(
                    value: 1,
                    groupValue: _selectedPaymentIndex,
                    onChanged: (v) =>
                        setState(() => _selectedPaymentIndex = v!),
                    title: const Text("ផ្ទេរប្រាក់តាមធនាគារ (ស្កេនQR)"),
                    subtitle: const Text("ABA, ACLEDA, Wing, ល.ល."),
                    activeColor: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "ការណែនាំបន្ថែម",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                  if (!hasAddress) ...[
                    const SizedBox(height: 12),
                    Text(
                      "សូមបញ្ចូលអាស័យដ្ឋានជាមុនសិន",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
                      onPressed: items.isEmpty || !hasAddress
                          ? null
                          : () {
                              orders.placeOrder(
                                items: items,
                                paymentMethod: selectedPaymentMethod,
                                address: savedAddress,
                              );
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
