import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Green Header Section ───────────────────────────────
          Container(
            width: double.infinity,
            color: Colors.green, // or Colors.green[700] for darker green
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 32), // top padding for status bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User avatar + name/email row
                Row(
                  children: [
                    // Avatar circle with person icon
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'ម្ចាស់គណនី',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'customer@chamkar.kh',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Scrollable list of menu items ──────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuTile(
                  icon: Icons.shopping_bag_outlined,
                  title: 'បញ្ជាក់ការបញ្ជាទិញ',
                  onTap: () {
                    // TODO: Navigate to orders screen
                    _showComingSoon(context);
                  },
                ),
                _buildMenuTile(
                  icon: Icons.favorite_border,
                  title: 'ចូលចិត្ត',
                  color: Colors.red,
                  onTap: () {
                    // TODO: Navigate to favorites
                    _showComingSoon(context);
                  },
                ),
                _buildMenuTile(
                  icon: Icons.location_on_outlined,
                  title: 'ទីតាំង',
                  onTap: () => _showComingSoon(context),
                ),
                _buildMenuTile(
                  icon: Icons.phone_outlined,
                  title: 'ទំនាក់ទំនង',
                  onTap: () => _showComingSoon(context),
                ),
                _buildMenuTile(
                  icon: Icons.settings_outlined,
                  title: 'ការកំណត់',
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
          ),

          // ── Logout button at bottom ────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Handle logout → e.g. clear auth → go to login
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('បានចាកចេញ សូមចូលម្តងទៀត')),
                );
                // Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'ចាកចេញ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(
            icon,
            color: color ?? Colors.green[800],
            size: 28,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('មុខងារកំពុងអភិវឌ្ឍន៍ ឆាប់ៗនេះ!')),
    );
  }
}