import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// កំណត់ ភាសា - ភាសាខ្មែរ, អង់គ្លេស
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selected = 0; // 0 Khmer, 1 English

  @override
  Widget build(BuildContext context) {
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
            groupValue: _selected,
            onChanged: (v) => setState(() => _selected = v!),
            title: const Text("ភាសាខ្មែរ"),
            activeColor: AppColors.primary,
          ),
          RadioListTile<int>(
            value: 1,
            groupValue: _selected,
            onChanged: (v) => setState(() => _selected = v!),
            title: const Text("អង់គ្លេស"),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
