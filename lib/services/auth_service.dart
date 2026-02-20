import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  // In-memory storage for mock users
  static List<Map<String, dynamic>> _mockUsers = [];

  // Currently logged-in user
  static Map<String, dynamic>? _currentUser;

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
    print('User logged out');
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