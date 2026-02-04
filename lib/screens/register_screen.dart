import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _LogoHeader(title: 'ចម្ការខ្មែរ', subtitle: 'ជួយសហគមន៍កសិករ'),
                  const SizedBox(height: 20),
                  _AuthCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ចុះឈ្មោះ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF567321),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _Label(text: 'ឈ្មោះ'),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'បញ្ចូលឈ្មោះ',
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _Label(text: 'លេខទូរស័ព្ទ'),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: '012 345 678',
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _Label(text: 'អ៊ីមែល'),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'example@gmail.com',
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _Label(text: 'ពាក្យសម្ងាត់'),
                        const SizedBox(height: 8),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'បញ្ចូលពាក្យសម្ងាត់',
                            suffixIcon: Icon(Icons.visibility_off, size: 18),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _Label(text: 'បញ្ជាក់ពាក្យសម្ងាត់'),
                        const SizedBox(height: 8),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'បញ្ជាក់ពាក្យសម្ងាត់',
                            suffixIcon: Icon(Icons.visibility_off, size: 18),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (_) {},
                              activeColor: const Color(0xFF7AA12B),
                            ),
                            const Expanded(
                              child: Text(
                                'ខ្ញុំយល់ព្រមលក្ខខណ្ឌ និងគោលការណ៍ឯកជន',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6E9E2E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'ចុះឈ្មោះ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const _SocialButton(
                          color: Color(0xFFF0F4E8),
                          icon: FontAwesomeIcons.google,
                          text: 'ចុះឈ្មោះដោយ Google',
                        ),
                        const SizedBox(height: 12),
                        const _SocialButton(
                          color: Color(0xFFF0F4E8),
                          icon: FontAwesomeIcons.facebook,
                          text: 'ចុះឈ្មោះដោយ Facebook',
                          iconColor: Color(0xFF1877F2),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('មានគណនីរួចហើយ? '),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'ចូលប្រើប្រាស់',
                                style: TextStyle(color: Color(0xFF7AA12B)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
          image: AssetImage('lib/assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(color: const Color(0xFFB7D38B).withOpacity(0.65)),
    );
  }
}

class _LogoHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _LogoHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset('lib/assets/images/img1.png'),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2E3A1F),
          ),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Color(0xFF567321))),
      ],
    );
  }
}

class _AuthCard extends StatelessWidget {
  final Widget child;

  const _AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFB7D38B)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF6E9E2E),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Color? iconColor;

  const _SocialButton({
    required this.color,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: Color(0xFFCBDDB1)),
        ),
        onPressed: () {},
        icon: FaIcon(icon, size: 16, color: iconColor ?? Colors.redAccent),
        label: Text(text, style: const TextStyle(color: Color(0xFF4E5B3C))),
      ),
    );
  }
}
