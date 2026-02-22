import 'package:flutter/material.dart';
import '../main_screen.dart';
import '../account/order_history_screen.dart';
import '../../core/theme/app_colors.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                "បញ្ជាទិញ ជោគជ័យ !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "អរគុណសម្រាប់ការបញ្ជាទិញរបស់អ្នក",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "លេខបញ្ជាទិញ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "#KH4034",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "ពេលវេលាដឹកជញ្ជូន ថ្ងៃស្អែក, 1:០០ - 2:០០",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    _buildStep("បានទទួលការបញ្ជាទិញ", true),
                    _buildStep("កំពុង រៀបចំ", false),
                    _buildStep("កំពុង ដឹកជញ្ជូន", false),
                    _buildStep("បានដឹកជញ្ជូន", false),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "យើងនឹងជូនដំណឹង អ្នក តាមសារ SMS ឬ តេឡេក្រាម នៅពេល ការបញ្ជាទិញរបស់ អ្នកកំពុង ដឹកជញ្ជូន",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderHistoryScreen(),
                      ),
                    );
                  },
                  child: const Text("មើលការបញ្ជាទិញរបស់ខ្ញុំ"),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text("ត្រឡប់ ទៅទំព័រដើម"),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "មានសំណួរ? ទាក់ទងមកយើង 012 345 678",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String label, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 22,
            color: done ? AppColors.success : Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: done ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
