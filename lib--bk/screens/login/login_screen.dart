import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _LogoHeader(title: 'ធម្មជាតិ', subtitle: 'ធម្មជាតិ'),
                  const SizedBox(height: 20),
                  _AuthCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'គណនី',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const _Label(text: 'ឈ្មោះអ្នកប្រើប្រាស់'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              hintText: 'ឈ្មោះអ្នកប្រើប្រាស់',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'សូមបញ្ចូលឈ្មោះអ្នកប្រើប្រាស់';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          const _Label(text: 'ពាក្យសម្ងាត់'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'បញ្ចូលពាក្យសម្ងាត់',
                              suffixIcon: Icon(Icons.visibility_off, size: 18),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'ពាក្យសម្ងាត់យ៉ាងតិច 6 តួអក្សរ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('ភ្លេចពាក្យសម្ងាត់?'),
                            ),
                          ),
                          const SizedBox(height: 4),
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
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthProvider>().login(
                                    displayName: _phoneController.text,
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/main',
                                  );
                                }
                              },
                              child: const Text(
                                'ចូលគណនី',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _SocialButton(
                            color: Color(0xFFF0F4E8),
                            icon: FontAwesomeIcons.google,
                            text: 'ចូលជាមួយ Google',
                            onPressed: () {
                              context.read<AuthProvider>().login(
                                displayName: 'Google User',
                              );
                              Navigator.pushReplacementNamed(context, '/main');
                            },
                          ),
                          const SizedBox(height: 12),
                          _SocialButton(
                            color: Color(0xFFF0F4E8),
                            icon: FontAwesomeIcons.facebook,
                            text: 'ចូលជាមួយ Facebook',
                            iconColor: Color(0xFF1877F2),
                            onPressed: () {
                              context.read<AuthProvider>().login(
                                displayName: 'Facebook User',
                              );
                              Navigator.pushReplacementNamed(context, '/main');
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('មិនទាន់មានគណនី? '),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const Text(
                                  'ចុះឈ្មោះគណនីថ្មី',
                                  style: TextStyle(color: Color(0xFF7AA12B)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
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
          width: 300,
          height: 100,

          // padding: const EdgeInsets.all(12),
          child: Image.asset('assets/images/img1.png'),
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
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.color,
    required this.icon,
    required this.text,
    this.iconColor,
    this.onPressed,
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
