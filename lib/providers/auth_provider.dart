// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _authService = AuthService();

//   bool _isLoggedIn = false;
//   bool get isLoggedIn => _isLoggedIn;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   Future<bool> login(String email, String password) async {
//     _isLoading = true;
//     notifyListeners();

//     bool success = await _authService.login(email, password);

//     if (success) {
//       _isLoggedIn = true;
//     }

//     _isLoading = false;
//     notifyListeners();

//     return success;
//   }

//   Future<void> logout() async {
//     await _authService.logout();
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Map<String, dynamic>? get user => _authService.currentUser;

  bool get isLoggedIn => user != null;

  Future<void> logout() async {
    await _authService.logout();
    notifyListeners(); // 🔥 REQUIRED
  }

  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    notifyListeners();
    return success;
  }
}