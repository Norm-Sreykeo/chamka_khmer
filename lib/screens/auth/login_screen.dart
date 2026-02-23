import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
import '../home/home_screen.dart';
import '../../services/auth_service.dart';
import '../../core/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _auth = AuthService();

  String? _errorMessage;

  // Google & Facebook login
  String? _userName;
  String? _userEmail;
  String? _userPhoto;

  Future<void> _loginWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    if (account != null) {
      setState(() {
        _userName = account.displayName;
        _userEmail = account.email;
        _userPhoto = account.photoUrl;
      });
      // Navigate to home or handle login
    }
  }

  Future<void> _loginWithFacebook() async {
    final result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      setState(() {
        _userName = userData['name'];
        _userEmail = userData['email'];
        _userPhoto = userData['picture']['data']['url'];
      });
      // Navigate to home or handle login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundWrapper(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 40),
                // ...existing code...
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7FBF5F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () async {
                      bool success = await _auth.login(
                        _emailController.text.trim(),
                        _passwordController.text,
                      );
                      if (success) {
                        print('Logged in as: ${_auth.currentUser?['fullName']}');
                        // Navigate to home
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 20),
                // Google login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.account_circle, color: Colors.red),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _loginWithGoogle,
                    label: const Text("Login with Google"),
                  ),
                ),
                const SizedBox(height: 10),
                // Facebook login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _loginWithFacebook,
                    label: const Text("Login with Facebook"),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
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
                          "Register",
                          style: TextStyle(
                            color: Color(0xFF7FBF5F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Show user info if logged in with Google/Facebook
                if (_userName != null)
                  Column(
                    children: [
                      if (_userPhoto != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(_userPhoto!),
                          radius: 40,
                        ),
                      Text('Name: $_userName'),
                      Text('Email: $_userEmail'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _userName = null;
                            _userEmail = null;
                            _userPhoto = null;
                          });
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );

                          // Login button
                          ElevatedButton(
                            onPressed: () async {
                              final success = await _auth.login(
                                _emailController.text.trim(),
                                _passwordController.text,
                              );

                              if (success) {
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                              } else if (_errorMessage != null) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(_errorMessage!),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7FBF5F),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              "ចូលគណនី",
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
                              Expanded(child: Divider(color: Colors.grey.shade400)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "ឬ",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.grey.shade400)),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Google button
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Implement Google Sign-In
                            },
                            icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
                            label: const Text("ចូលតាម Google"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Facebook button
                          OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Implement Facebook Sign-In
                            },
                            icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 28),
                            label: const Text("ចូលតាម Facebook"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Register link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "មិនទាន់មានគណនី? ",
                                style: TextStyle(color: Colors.grey.shade700),
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
                                    color: Color(0xFF7FBF5F),
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