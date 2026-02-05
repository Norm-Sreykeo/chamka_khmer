import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _displayName;

  bool get isLoggedIn => _isLoggedIn;
  String? get displayName => _displayName;

  void login({required String displayName}) {
    _isLoggedIn = true;
    _displayName = displayName;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _displayName = null;
    notifyListeners();
  }
}
