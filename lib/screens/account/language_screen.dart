import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/settings_provider.dart';

/// កំណត់ ភាសា - ភាសាខ្មែរ, អង់គ្លេស
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final selected = settings.languageIndex;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("កំណត់ ភាសា"),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RadioListTile<int>(
            value: 0,
            groupValue: selected,
            onChanged: (v) {
              if (v == null) return;
              settings.setLanguageIndex(v);
            },
            title: const Text("ភាសាខ្មែរ"),
            activeColor: AppColors.primary,
          ),
          RadioListTile<int>(
            value: 1,
            groupValue: selected,
            onChanged: (v) {
              if (v == null) return;
              settings.setLanguageIndex(v);
            },
            title: const Text("អង់គ្លេស"),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
