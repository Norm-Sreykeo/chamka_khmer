// class AuthService {

//   /// mock login
//   Future<bool> login(String email, String password) async {
//     await Future.delayed(const Duration(seconds: 1));

//     if (email == "admin@test.com" && password == "123456") {
//       return true;
//     }
//     return false;
//   }

//   /// mock register
//   Future<bool> register(String email, String password) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return true;
//   }

//   /// logout
//   Future<void> logout() async {
//     // clear tokens later
//   }
// }


// // final auth = AuthService();

// // bool success = await auth.login(email, password);

// // if (success) {
// //   // go to home
// // }


// lib/services/auth_service.dart

class AuthService {
  // In-memory "database" for mock purposes (simulates registered users)
  static final List<Map<String, dynamic>> _mockUsers = [];

  /// Mock login
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800)); // realistic delay

    // Find user by email (case insensitive for realism)
    final user = _mockUsers.firstWhere(
      (u) => u['email'].toString().toLowerCase() == email.toLowerCase(),
      orElse: () => <String, dynamic>{},
    );

    if (user.isNotEmpty && user['password'] == password) {
      // In real app → save token / set current user here
      print('Mock login success: $email');
      return true;
    }

    print('Mock login failed: $email');
    return false;
  }

  /// Mock register – now accepts fullName and phone
  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // Simple mock validation
    if (email.isEmpty || password.isEmpty || fullName.isEmpty || phone.isEmpty) {
      print('Register failed: missing fields');
      return false;
    }

    // Check if email already exists (mock duplicate check)
    final exists = _mockUsers.any(
      (u) => u['email'].toString().toLowerCase() == email.toLowerCase(),
    );

    if (exists) {
      print('Register failed: email already in use → $email');
      return false;
    }

    // "Save" new user
    _mockUsers.add({
      'email': email.toLowerCase(),
      'password': password, // plain text – only for mock!
      'fullName': fullName,
      'phone': phone,
      'createdAt': DateTime.now().toIso8601String(),
    });

    print('Mock register success: $email | $fullName | $phone');
    return true;
  }

  /// Logout (mock)
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 400));
    print('Mock logout performed');
    // In real app: signOut from Firebase, clear SharedPreferences / secure storage, etc.
  }

  // --------------------------------------------------------------------------
  // Helper for testing / debugging (optional)
  // --------------------------------------------------------------------------
  static void printAllMockUsers() {
    if (_mockUsers.isEmpty) {
      print('No mock users registered yet.');
      return;
    }
    print('Mock registered users (${_mockUsers.length}):');
    for (var user in _mockUsers) {
      print('  - ${user['email']} | ${user['fullName']} | ${user['phone']}');
    }
  }

  // --------------------------------------------------------------------------
  // Future real Firebase version (commented out – uncomment when ready)
  // --------------------------------------------------------------------------
  /*
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = cred.user;
      if (user == null) return false;

      await user.updateDisplayName(fullName);

      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullName,
        'phone': phone,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print('Firebase register error: $e');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Firebase login error: $e');
      return false;
    }
  }
  */
}