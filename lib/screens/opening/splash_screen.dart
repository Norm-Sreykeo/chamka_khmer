import 'package:flutter/material.dart';
import '../main_screen.dart';
import '../../services/auth_service.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // IMPORTANT: re-check latest stored session
    await AuthService.initialize();

    if (!mounted) return;

    final user = _auth.currentUser;

    if (user != null) {
      // ✅ Logged in → go to main screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } else {
      // ❌ Not logged in → onboarding
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/images/img1.png"),

            const SizedBox(height: 20),

            const Text(
              "ចម្ការខ្មែរ",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "ផ្លែឈើនិង បន្លែស្រស់ពីចម្ការ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
