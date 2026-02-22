import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'language_screen.dart';

/// ការកំណត់: ការជូនដំណឹង, ភាសា, មុខងារងងឹត, ឯកជនភាព, ល័ក្ខខណ្ឌ, ជំនួយ, អំពីយើង
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifyOrder = true;
  bool _notifyPromo = true;
  bool _notifyNewProduct = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("ការកំណត់"),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "ការជូនដំណឹង",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            value: _notifyOrder,
            onChanged: (v) => setState(() => _notifyOrder = v),
            title: const Text("ការបញ្ជាទិញ"),
            subtitle: const Text(
                "ទទួលបានការជូនដំណឹងអំពីការបញ្ជាទិញរបស់អ្នក"),
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            value: _notifyPromo,
            onChanged: (v) => setState(() => _notifyPromo = v),
            title: const Text("ការផ្តល់ជូន"),
            subtitle: const Text(
                "ទទួលបានការជូនដំណឹងអំពីការ ផ្តល់ជូនពិសេស"),
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            value: _notifyNewProduct,
            onChanged: (v) => setState(() => _notifyNewProduct = v),
            title: const Text("ផលិតផលថ្មី"),
            subtitle: const Text("ទទួលការជូនដំណឹងពី ផលិតផលថ្មី"),
            activeColor: AppColors.primary,
          ),
          const SizedBox(height: 24),
          const Text(
            "ការចូលចិត្ត",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.language, color: AppColors.primary),
            title: const Text("ភាសា"),
            subtitle: const Text("ភាសាខ្មែរ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LanguageScreen(),
              ),
            ),
          ),
          SwitchListTile(
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
            title: const Text("មុខងារងងឹត"),
            activeColor: AppColors.primary,
          ),
          const SizedBox(height: 24),
          const Text(
            "ឯកជនភាព និង សុវត្ថិភាព",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text("គោលការណ៍ឯកជនភាព"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("ល័ក្ខខណ្ឌ នៃការ ប្រើប្រាស់"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            "ជំនួយ និង ការ គាំទ្រ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("ត្រូវការជំនួយ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("អំពីយើង"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
