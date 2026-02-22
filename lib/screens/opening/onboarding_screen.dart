import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../main_screen.dart';
import '../../services/auth_service.dart';
import '../../widgets/background_wrapper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final AuthService _auth = AuthService();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirectIfAlreadyLoggedIn());
  }

  void _redirectIfAlreadyLoggedIn() {
    if (_auth.currentUser != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  final List<Map<String, String>> pages = [
    {
      "image": "lib/assets/images/background.png",
      "title": "ស្វាគមន៍មកកាន់",
      "subtitle": "ទិញបន្លែផ្លែឈើស្រស់ៗ ងាយស្រួល និងរហ័ស",
    },
    {
      "image": "lib/assets/images/background.png",
      "title": "គុណភាពល្អបំផុត",
      "subtitle": "ផលិតផលស្រស់ពីកសិករ ដល់ផ្ទះអ្នក",
    },
    {
      "image": "lib/assets/images/background.png",
      "title": "ដឹកជញ្ជូនលឿន",
      "subtitle": "ទទួលបានទំនិញក្នុងពេលខ្លី",
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('lib/assets/images/background.png'),
      context,
    );
    precacheImage(const AssetImage('lib/assets/images/img1.png'), context);
  }

  void nextPage() {
    if (currentIndex == pages.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F3EA),
      body: BackgroundWrapper(
        child: Stack(
          children: [
           // Container(color: const Color(0xFF7FBF5F).withOpacity(0.30)),
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemCount: pages.length,
                    itemBuilder: (_, i) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/img1.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                pages[i]["title"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B1B1B),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                pages[i]["subtitle"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2E2E2E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(4),
                      width: currentIndex == index ? 14 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? const Color(0xFF7FBF5F)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Skip"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7FBF5F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: nextPage,
                        child: Text(
                          currentIndex == pages.length - 1 ? "Start" : "Next",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
