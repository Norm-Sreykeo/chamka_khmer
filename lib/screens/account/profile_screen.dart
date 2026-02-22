import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import 'order_history_screen.dart';
import 'favorites_screen.dart';
import 'address_screen.dart';
import 'settings_screen.dart';
import '../auth/login_screen.dart';
import '../main_screen.dart';

/// គណនី: អតិថិជន, ប្រវត្តិការបញ្ជាទិញ, ចំណូលចិត្ត, អាសយដ្ឋាន, ទំនាក់ទំនង, ការកំណត់, ចាកចេញ
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final email = auth.currentUser?['email'] ?? 'customer@chamkar.kh';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("គណនី"),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
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
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 36,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "អតិថិជន",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _menuTile(
            context,
            icon: Icons.history,
            title: "ប្រវត្តិការបញ្ជាទិញ",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OrderHistoryScreen(),
              ),
            ),
          ),
          _menuTile(
            context,
            icon: Icons.favorite_border,
            title: "ចំណូលចិត្ត",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FavoritesScreen(),
              ),
            ),
          ),
          _menuTile(
            context,
            icon: Icons.location_on_outlined,
            title: "អាសយដ្ឋាន",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddressScreen(),
              ),
            ),
          ),
          _menuTile(
            context,
            icon: Icons.contact_phone_outlined,
            title: "ទំនាក់ទំនង",
            onTap: () {
              // Could open phone/email
            },
          ),
          _menuTile(
            context,
            icon: Icons.settings,
            title: "ការកំណត់",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsScreen(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _menuTile(
            context,
            icon: Icons.logout,
            title: "ចាកចេញ",
            textColor: Colors.red,
            onTap: () async {
              await auth.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: textColor ?? AppColors.primary),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
