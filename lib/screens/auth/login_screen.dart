// import 'package:flutter/material.dart';

// import 'register_screen.dart';
// import 'forgot_password_screen.dart';
// import '../home/home_screen.dart';
// import '../../services/auth_service.dart';
// import '../../core/utils/validators.dart';
// import '../../widgets/background_wrapper.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   final _auth = AuthService();

//   String? _errorMessage;
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: BackgroundWrapper(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),

//                 const Text(
//                   "Welcome Back 👋",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 const Text(
//                   "Login to continue",
//                   style: TextStyle(color: Colors.white70),
//                 ),

//                 const SizedBox(height: 40),

//                 /// Email
//                 TextField(
//                   controller: _emailController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     labelStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.2),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),

//                 ),

//                 const SizedBox(height: 20),

//                 /// Password
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscurePassword,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     labelStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.2),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ForgotPasswordScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Forgot Password?",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 /// Login Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF7FBF5F),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     onPressed: () async {
//                       bool success = await _auth.login(
//                         _emailController.text.trim(),
//                         _passwordController.text,
//                       );

//                       if (success) {
//                         print('Logged in as: ${_auth.currentUser?['fullName']}');
//                         // Navigate to home
//                       }

//                     },
//                     child: const Text("Login"),
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account? ",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const RegisterScreen(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Register",
//                           style: TextStyle(
//                             color: Color(0xFF7FBF5F),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../main_screen.dart';
import '../../services/auth_service.dart';
import '../../core/utils/validators.dart';
import '../../core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _auth = AuthService();

  String? _errorMessage;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "lib/assets/images/background.png",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.35),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "lib/assets/images/img1.png",
                      height: 100,
                      filterQuality: FilterQuality.medium,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "ចម្ការខ្មែរ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ផ្លែឈើនិង បន្លែស្រស់ពីចម្ការ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.06),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "ចូលគណនី",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "បញ្ចូលព័ត៌មានរបស់អ្នកដើម្បីចូល",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 28),

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "លេខទូរស័ព្ទឬ អ៊ីមែល",
                              hintText: "បញ្ចូលលេខទូរស័ព្ទឬ អ៊ីមែល",
                              labelStyle: TextStyle(color: AppColors.textSecondary),
                              filled: true,
                              fillColor: AppColors.background,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: AppColors.border,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'សូមបញ្ចូលលេខទូរស័ព្ទឬអ៊ីមែល'
                                    : null,
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: "ពាក្យសម្ងាត់",
                              hintText: "បញ្ចូលពាក្យសម្ងាត់",
                              labelStyle: TextStyle(color: AppColors.textSecondary),
                              filled: true,
                              fillColor: AppColors.background,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: AppColors.border,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  );
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) => Validators.password(value),
                          ),

                          const SizedBox(height: 12),

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "ភ្លេចពាក្យសម្ងាត់?",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Login button
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    setState(() => _isLoading = true);

                                    final success = await _auth.login(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    );

                                    if (!context.mounted) return;
                                    if (success) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const MainScreen(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _errorMessage ?? "ការចូលគណនីបរាជ័យ",
                                          ),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }

                                    if (context.mounted) {
                                      setState(() => _isLoading = false);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    "ចូលប្រើប្រាស់",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),

                          const SizedBox(height: 32),

                          // Or divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: AppColors.border),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  "ឬ",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(color: AppColors.border),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Google button
                          OutlinedButton.icon(
                            onPressed: _isGoogleLoading
                                ? null
                                : () async {
                                    setState(() => _isGoogleLoading = true);

                                    final success = await _auth
                                        .signInWithGoogle();

                                    if (!context.mounted) return;
                                    if (success) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const MainScreen(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "ការចូលតាម Google បរាជ័យ",
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }

                                    if (context.mounted) {
                                      setState(() => _isGoogleLoading = false);
                                    }
                                  },
                            icon: _isGoogleLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.red,
                                    size: 28,
                                  ),
                            label: Text(
                              _isGoogleLoading
                                  ? "កំពុងភ្ជាប់..."
                                  : "ចូលដោយ Google",
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: BorderSide(color: AppColors.border),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          OutlinedButton.icon(
                            onPressed: _isFacebookLoading
                                ? null
                                : () async {
                                    setState(() => _isFacebookLoading = true);

                                    final success = await _auth
                                        .signInWithFacebook();

                                    if (!context.mounted) return;
                                    if (success) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const MainScreen(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "ការចូលតាម Facebook បរាជ័យ",
                                          ),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }

                                    if (context.mounted) {
                                      setState(
                                        () => _isFacebookLoading = false,
                                      );
                                    }
                                  },
                            icon: _isFacebookLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF1877F2),
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.facebook,
                                    color: Color(0xFF1877F2),
                                    size: 28,
                                  ),
                            label: Text(
                              _isFacebookLoading
                                  ? "កំពុងភ្ជាប់..."
                                  : "ចូលដោយ Facebook",
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: BorderSide(color: AppColors.border),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "មិនទាន់មានគណនី? ",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "ចុះឈ្មោះ",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
