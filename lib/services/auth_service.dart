import 'dart:async';

class AuthService {
  // In-memory storage for mock users
  static final List<Map<String, dynamic>> _mockUsers = [];

  // Simulate current logged-in user (null = not logged in)
  static Map<String, dynamic>? _currentUser;

  /// Get currently "logged in" user (for testing protected screens)
  Map<String, dynamic>? get currentUser => _currentUser;

  /// Mock login – now sets currentUser on success
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final normalizedEmail = email.trim().toLowerCase();

    final user = _mockUsers.firstWhere(
      (u) => u['email'] == normalizedEmail,
      orElse: () => <String, dynamic>{},
    );

    if (user.isNotEmpty && user['password'] == password) {
      _currentUser = Map.from(user)..remove('password'); // don't store password in session
      print('Mock login SUCCESS: $normalizedEmail → ${_currentUser!['fullName']}');
      return true;
    }

    print('Mock login FAILED: $normalizedEmail - invalid credentials');
    return false;
  }

  /// Mock register
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
      print('Mock register FAILED: missing required fields');
      return false;
    }

    final emailExists = _mockUsers.any(
      (u) => u['email'] == normalizedEmail,
    );

    if (emailExists) {
      print('Mock register FAILED: email already in use → $normalizedEmail');
      return false;
    }

    final newUser = {
      'email': normalizedEmail,
      'password': password, // plain text – ONLY for mock/testing!
      'fullName': fullName.trim(),
      'phone': phone.trim(),
      'createdAt': DateTime.now().toIso8601String(),
    };

    _mockUsers.add(newUser);
    print('Mock register SUCCESS: $normalizedEmail | $fullName | $phone');

    // Optional: auto-login after register (common UX pattern)
    // _currentUser = Map.from(newUser)..remove('password');

    return true;
  }

  /// Mock password reset
  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    final normalizedEmail = email.trim().toLowerCase();

    final userExists = _mockUsers.any(
      (u) => u['email'] == normalizedEmail,
    );

    if (!userExists) {
      print('Mock reset FAILED: email not found → $normalizedEmail');
      return false;
    }

    print('Mock reset link "sent" to: $normalizedEmail');
    // In real app: send actual email
    // Here we just pretend it worked
    return true;
  }

  /// Mock logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final wasLoggedIn = _currentUser != null;
    _currentUser = null;
    print('Mock logout performed${wasLoggedIn ? " (user was logged in)" : ""}');
  }

  // --------------------------------------------------------------------------
  // Debugging helper – call from anywhere (e.g. debug button)
  // --------------------------------------------------------------------------
  static void debugPrintUsers() {
    if (_mockUsers.isEmpty) {
      print('No mock users registered yet.');
      return;
    }
    print('=== Mock Users (${_mockUsers.length}) ===');
    for (var u in _mockUsers) {
      print(' • ${u['email']} | ${u['fullName']} | ${u['phone']}');
    }
    print('Current logged in: ${_currentUser?['email'] ?? "nobody"}');
    print('========================');
  }

  // Clear everything (useful for testing / hot restart)
  static void debugClearAll() {
    _mockUsers.clear();
    _currentUser = null;
    print('Mock AuthService cleared');
  }
}