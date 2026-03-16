import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Social login instances
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static StreamSubscription<User?>? _authSub;
  static Map<String, dynamic>? _currentUser;

  Map<String, dynamic>? get currentUser => _currentUser;

  // --------------------------------------------------------------------------
  // Initialization: load users and current user from storage
  // --------------------------------------------------------------------------
  static Future<void> initialize() async {
    _currentUser = await _buildCurrentUser(_auth.currentUser);
    _authSub?.cancel();
    _authSub = _auth.authStateChanges().listen((u) async {
      _currentUser = await _buildCurrentUser(u);
    });
  }

  static Future<Map<String, dynamic>?> _buildCurrentUser(User? user) async {
    final base = _userToMap(user);
    if (base == null) return null;

    try {
      final uid = base['uid'] as String?;
      if (uid == null || uid.isEmpty) return base;

      final snap = await _firestore.collection('users').doc(uid).get();
      final data = snap.data();
      if (data == null) return base;

      return {
        ...base,
        'fullName': (data['fullName'] ?? base['fullName'] ?? '').toString(),
        'phone': (data['phone'] ?? base['phone'] ?? '').toString(),
        'address': data['address'],
      };
    } catch (e) {
      return base;
    }
  }

  static Map<String, dynamic>? _userToMap(User? user) {
    if (user == null) return null;
    return {
      'uid': user.uid,
      'email': user.email ?? '',
      'fullName': user.displayName ?? '',
      'phone': user.phoneNumber ?? '',
      'photoUrl': user.photoURL,
      'loginMethod': 'firebase',
    };
  }

  // --------------------------------------------------------------------------
  // Login
  // --------------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final cred = await _auth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      _currentUser = await _buildCurrentUser(cred.user);
      return cred.user != null;
    } catch (e) {
      return false;
    }
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
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final cred = await _auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      final user = cred.user;
      if (user == null) return false;

      await user.updateDisplayName(fullName.trim());

      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullName.trim(),
        'phone': phone.trim(),
        'email': normalizedEmail,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      _currentUser = await _buildCurrentUser(_auth.currentUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAddress(String address) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null || uid.isEmpty) return false;

      final trimmed = address.trim();
      await _firestore.collection('users').doc(uid).set({
        'address': trimmed,
      }, SetOptions(merge: true));

      _currentUser = {...?_currentUser, 'address': trimmed};

      return true;
    } catch (e) {
      return false;
    }
  }

  // --------------------------------------------------------------------------
  // Password reset
  // --------------------------------------------------------------------------
  Future<bool> resetPassword(String email) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      await _auth.sendPasswordResetEmail(email: normalizedEmail);
      return true;
    } catch (e) {
      return false;
    }
  }

  // --------------------------------------------------------------------------
  // Logout
  // --------------------------------------------------------------------------
  Future<void> logout() async {
    _currentUser = null;
    await _auth.signOut();

    // 3️⃣ Google logout safely
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }
    } catch (e) {
      print('Google logout error: $e');
    }

    // 4️⃣ Facebook logout safely
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      print('Facebook logout error: $e');
    }
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

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final cred = await _auth.signInWithCredential(credential);
      _currentUser = await _buildCurrentUser(cred.user);
      return cred.user != null;
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

      final accessToken = result.accessToken;
      if (accessToken == null) return false;

      final credential = FacebookAuthProvider.credential(accessToken.token);
      final cred = await _auth.signInWithCredential(credential);
      _currentUser = await _buildCurrentUser(cred.user);
      return cred.user != null;
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
    print('Current logged in: ${_currentUser?['email'] ?? "nobody"}');
  }

  static Future<void> debugClearAll() async {
    _currentUser = null;
    await _auth.signOut();
  }
}
