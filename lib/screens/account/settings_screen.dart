import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/settings_provider.dart';
import 'language_screen.dart';

/// ការកំណត់: ការជូនដំណឹង, ភាសា, មុខងារងងឹត, ឯកជនភាព, ល័ក្ខខណ្ឌ, ជំនួយ, អំពីយើង
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _showInfoDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

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
            value: settings.notifyOrder,
            onChanged: (v) => settings.setNotifyOrder(v),
            title: const Text("ការបញ្ជាទិញ"),
            subtitle: const Text("ទទួលបានការជូនដំណឹងអំពីការបញ្ជាទិញរបស់អ្នក"),
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            value: settings.notifyPromo,
            onChanged: (v) => settings.setNotifyPromo(v),
            title: const Text("ការផ្តល់ជូន"),
            subtitle: const Text("ទទួលបានការជូនដំណឹងអំពីការ ផ្តល់ជូនពិសេស"),
            activeColor: AppColors.primary,
          ),
          SwitchListTile(
            value: settings.notifyNewProduct,
            onChanged: (v) => settings.setNotifyNewProduct(v),
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
              MaterialPageRoute(builder: (_) => const LanguageScreen()),
            ),
          ),
          SwitchListTile(
            value: settings.darkMode,
            onChanged: (v) => settings.setDarkMode(v),
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
            onTap: () => _showInfoDialog(
              context,
              title: 'គោលការណ៍ឯកជនភាព',
              content:
                  'ព័ត៌មាននេះជាគំរូ (placeholder)។ ប្រសិនបើអ្នកមានអត្ថបទគោលការណ៍ឯកជនភាព សូមផ្ញើមក ខ្ញុំនឹងដាក់បង្ហាញនៅទីនេះ។',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("ល័ក្ខខណ្ឌ នៃការ ប្រើប្រាស់"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showInfoDialog(
              context,
              title: 'ល័ក្ខខណ្ឌ នៃការ ប្រើប្រាស់',
              content:
                  'ព័ត៌មាននេះជាគំរូ (placeholder)។ ប្រសិនបើអ្នកមានអត្ថបទល័ក្ខខណ្ឌប្រើប្រាស់ សូមផ្ញើមក ខ្ញុំនឹងដាក់បង្ហាញនៅទីនេះ។',
            ),
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
            onTap: () => _showInfoDialog(
              context,
              title: 'ត្រូវការជំនួយ',
              content:
                  'សូមទំនាក់ទំនង៖\n- Email: support@chamkar.kh\n- Phone: 012 345 678',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("អំពីយើង"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showInfoDialog(
              context,
              title: 'អំពីយើង',
              content:
                  'ចម្ការខ្មែរ - ផ្លែឈើ និងបន្លែស្រស់ពីចម្ការ។\n\nVersion: 1.0.0',
            ),
          ),
        ],
      ),
    );
  }
}
