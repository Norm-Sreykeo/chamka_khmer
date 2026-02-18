class AuthService {

  /// mock login
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "admin@test.com" && password == "123456") {
      return true;
    }
    return false;
  }

  /// mock register
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// logout
  Future<void> logout() async {
    // clear tokens later
  }
}


// final auth = AuthService();

// bool success = await auth.login(email, password);

// if (success) {
//   // go to home
// }
