import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../services/auth_service.dart';

/// អាសយដ្ឋាន - ផ្ទះ, កន្លែងធ្វើការ, កែសម្រួល, លំនាំដើម, បន្ថែមអាសយដ្ឋានថ្មី
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _addressController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final current = _auth.currentUser;
    _addressController.text = (current?['address'] ?? '').toString();
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final ok = await _auth.updateAddress(_addressController.text);

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? "រក្សាទុកអាសយដ្ឋានបានជោគជ័យ"
              : "រក្សាទុកមិនបាន សូមព្យាយាមម្ដងទៀត",
        ),
        backgroundColor: ok ? AppColors.success : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final name = (user?['fullName'] ?? '').toString();
    final phone = (user?['phone'] ?? '').toString();
    final hasUser = user != null;

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
          if (!hasUser)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "សូមចូលគណនីជាមុនសិន",
                style: TextStyle(fontSize: 14),
              ),
            )
          else
            _addressCard(
              title: "អាសយដ្ឋាន",
              name: name.isEmpty ? "-" : name,
              phone: phone.isEmpty ? "-" : phone,
              addressController: _addressController,
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: hasUser && !_isSaving ? _save : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("រក្សាទុក"),
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
    required TextEditingController addressController,
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
            ],
          ),
          const SizedBox(height: 8),
          Text("ឈ្មោះ: $name", style: const TextStyle(fontSize: 14)),
          Text("លេខទូរស័ព្ទ: $phone", style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          TextField(
            controller: addressController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "បញ្ចូលអាសយដ្ឋាន",
              filled: true,
              fillColor: AppColors.background,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
