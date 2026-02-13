import 'package:flutter/material.dart';
import 'login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) =>
                        setState(() => _pageIndex = value),
                    children: const [
                      _LoadingPage(
                        title: 'ចម្ការខ្មែរ',
                        subtitle: 'ផ្លែឈើ និង បន្លែស្រស់ពីចម្ការ',
                      ),
                      _LoadingPage(
                        title: 'ទំនាក់ទំនងផ្ទាល់',
                        subtitle: 'ទិញ-លក់ផលិតផលស្រស់',
                      ),
                      _LoadingPage(
                        title: 'ចាប់ផ្តើមឥឡូវនេះ',
                        subtitle: 'គ្រប់គ្រងដោយទំនុកចិត្ត',
                      ),
                    ],
                  ),
                ),
                _DotsIndicator(activeIndex: _pageIndex),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF6E9E2E,
                    ), // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: const EdgeInsets.all(14),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // Radius (rounded corners)
                    ),
                  ),
                  child: const Text(
                    'ចូលទៅគណនី',
                    style: TextStyle(
                      color: Color.fromARGB(255, 239, 240, 239),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const _LoadingPage({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(),
            padding: const EdgeInsets.all(14),
            child: Image.asset('assets/images/img1.png'),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E3A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int activeIndex;

  const _DotsIndicator({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        );
      }),
    );
  }
}

class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
