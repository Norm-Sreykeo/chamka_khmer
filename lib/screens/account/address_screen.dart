import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// អាសយដ្ឋាន - ផ្ទះ, កន្លែងធ្វើការ, កែសម្រួល, លំនាំដើម, បន្ថែមអាសយដ្ឋានថ្មី
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("អាសយដ្ឋាន"),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _addressCard(
            title: "ផ្ទះ",
            name: "សុខ ចន្ថា",
            phone: "093 846 485",
            address:
                "ផ្ទះលេខ ៣៥, ផ្លូវ ២៨៨, សង្កាត់ទឹកល្អក់ ១, ខណ្ឌ ទួល គោក, រាជធានីភ្នំពេញ",
            isDefault: true,
          ),
          const SizedBox(height: 12),
          _addressCard(
            title: "កន្លែង ធ្វើ ការ",
            name: "សុខ ចន្ថា",
            phone: "093 846 485",
            address:
                "ផ្ទះលេខ ៣៥, ផ្លូវ ២៨៨, សង្កាត់ទឹកល្អក់ ១, ខណ្ឌ ទួល គោក, រាជធានីភ្នំពេញ",
            isDefault: false,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("បន្ថែមអាសយដ្ឋានថ្មី"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressCard({
    required String title,
    required String name,
    required String phone,
    required String address,
    required bool isDefault,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("កែសម្រួល"),
              ),
              if (isDefault)
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "លំនាំដើម",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text("ឈ្មោះ: $name", style: const TextStyle(fontSize: 14)),
          Text("លេខទូរស័ព្ទ: $phone",
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text("អាសយដ្ឋានៈ $address",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}
