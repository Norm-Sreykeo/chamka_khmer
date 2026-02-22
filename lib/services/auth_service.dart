import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  // In-memory storage for mock users
  static List<Map<String, dynamic>> _mockUsers = [];

  // Currently logged-in user
  static Map<String, dynamic>? _currentUser;

  // Social login instances
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  Map<String, dynamic>? get currentUser => _currentUser;

  // --------------------------------------------------------------------------
  // Initialization: load users and current user from storage
  // --------------------------------------------------------------------------
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    // Load saved users
    final usersJson = prefs.getString('mockUsers');
    if (usersJson != null) {
      _mockUsers = List<Map<String, dynamic>>.from(
        (json.decode(usersJson) as List<dynamic>),
      );
    }

    // Load last logged-in user
    final currentUserJson = prefs.getString('currentUser');
    if (currentUserJson != null) {
      _currentUser = Map<String, dynamic>.from(json.decode(currentUserJson));
      print('Loaded logged-in user: ${_currentUser!['email']}');
    }
  }

  // --------------------------------------------------------------------------
  // Save current state to SharedPreferences
  // --------------------------------------------------------------------------
  static Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mockUsers', json.encode(_mockUsers));
  }

  static Future<void> _saveCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentUser != null) {
      await prefs.setString('currentUser', json.encode(_currentUser));
    } else {
      await prefs.remove('currentUser');
    }
  }

  // --------------------------------------------------------------------------
  // Login
  // --------------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final normalizedEmail = email.trim().toLowerCase();

    final user = _mockUsers.firstWhere(
      (u) => u['email'] == normalizedEmail,
      orElse: () => <String, dynamic>{},
    );

    if (user.isNotEmpty && user['password'] == password) {
      _currentUser = Map.from(user)..remove('password');
      await _saveCurrentUser();
      print('Login SUCCESS: $normalizedEmail → ${_currentUser!['fullName']}');
      return true;
    }

    print('Login FAILED: $normalizedEmail - invalid credentials');
    return false;
  }

  // --------------------------------------------------------------------------
  // Register
  // --------------------------------------------------------------------------
  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty ||
        password.isEmpty ||
        fullName.trim().isEmpty ||
        phone.trim().isEmpty) {
      print('Register FAILED: missing required fields');
      return false;
    }

    final emailExists = _mockUsers.any((u) => u['email'] == normalizedEmail);

    if (emailExists) {
      print('Register FAILED: email already in use → $normalizedEmail');
      return false;
    }

    final newUser = {
      'email': normalizedEmail,
      'password': password, // only for mock
      'fullName': fullName.trim(),
      'phone': phone.trim(),
      'createdAt': DateTime.now().toIso8601String(),
    };

    _mockUsers.add(newUser);
    await _saveUsers();

    // Auto-login after registration
    _currentUser = Map.from(newUser)..remove('password');
    await _saveCurrentUser();

    print('Register SUCCESS: $normalizedEmail | $fullName | $phone');
    return true;
  }

  // --------------------------------------------------------------------------
  // Password reset
  // --------------------------------------------------------------------------
  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final normalizedEmail = email.trim().toLowerCase();

    final userExists = _mockUsers.any((u) => u['email'] == normalizedEmail);

    if (!userExists) {
      print('Reset FAILED: email not found → $normalizedEmail');
      return false;
    }

    print('Reset link "sent" to: $normalizedEmail');
    return true;
  }

  // --------------------------------------------------------------------------
  // Logout
  // --------------------------------------------------------------------------
  Future<void> logout() async {
    _currentUser = null;
    await _saveCurrentUser();
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    print('User logged out');
  }

  // --------------------------------------------------------------------------
  // Google Sign-In
  // --------------------------------------------------------------------------
  Future<bool> signInWithGoogle() async {
    try {
      print('Starting Google Sign-In...');

      // If user is already signed in, sign them out first
      if (await _googleSignIn.isSignedIn()) {
        print('User already signed in, signing out first...');
        await _googleSignIn.signOut();
      }

      print('Attempting to sign in with Google...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('Google Sign-In cancelled by user');
        return false;
      }

      print('Google Sign-In successful for: ${googleUser.email}');

      // Create user data from Google account
      _currentUser = {
        'email': googleUser.email,
        'fullName': googleUser.displayName ?? 'Google User',
        'phone': '',
        'photoUrl': googleUser.photoUrl,
        'loginMethod': 'google',
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _saveCurrentUser();
      print(
        'Google Sign-In SUCCESS: ${_currentUser!['email']} → ${_currentUser!['fullName']}',
      );
      return true;
    } catch (e) {
      print('Google Sign-In ERROR: $e');
      print('Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  // --------------------------------------------------------------------------
  // Facebook Sign-In
  // --------------------------------------------------------------------------
  Future<bool> signInWithFacebook() async {
    try {
      print('Starting Facebook Sign-In...');

      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.cancelled) {
        print('Facebook Sign-In cancelled by user');
        return false;
      }

      if (result.status != LoginStatus.success) {
        print('Facebook Sign-In failed: ${result.message}');
        return false;
      }

      print('Facebook Sign-In successful, getting user data...');
      final userData = await FacebookAuth.instance.getUserData();

      print('Facebook user data received: ${userData['name']}');

      // Create user data from Facebook account
      _currentUser = {
        'email': userData['email'] ?? '',
        'fullName': userData['name'] ?? 'Facebook User',
        'phone': '',
        'photoUrl': userData['picture']['data']['url'] ?? '',
        'loginMethod': 'facebook',
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _saveCurrentUser();
      print(
        'Facebook Sign-In SUCCESS: ${_currentUser!['email']} → ${_currentUser!['fullName']}',
      );
      return true;
    } catch (e) {
      print('Facebook Sign-In ERROR: $e');
      print('Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  // --------------------------------------------------------------------------
  // Debug
  // --------------------------------------------------------------------------
  static void debugPrintUsers() {
    if (_mockUsers.isEmpty) {
      print('No users registered yet.');
      return;
    }

    print('=== Mock Users (${_mockUsers.length}) ===');
    for (var u in _mockUsers) {
      print(' • ${u['email']} | ${u['fullName']} | ${u['phone']}');
    }
    print('Current logged in: ${_currentUser?['email'] ?? "nobody"}');
    print('========================');
  }

  static Future<void> debugClearAll() async {
    _mockUsers.clear();
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('mockUsers');
    await prefs.remove('currentUser');
    print('AuthService cleared');
  }
}
