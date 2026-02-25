import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform - run flutterfire configure.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for fuchsia.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_5w4hVBotfaaV43hZj4XC6UpgDYZacQs',
    appId: '1:585828674142:android:773d05f2473bacf20722cf',
    messagingSenderId: '585828674142',
    projectId: 'chamka-khmer-8eb3b',
    storageBucket: 'chamka-khmer-8eb3b.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhMisJZwD7pzOyj464UJDg-Io5rmz1Hdg',
    appId: '1:585828674142:web:1c28f5e55ce0d6c10722cf',
    messagingSenderId: '585828674142',
    projectId: 'chamka-khmer-8eb3b',
    authDomain: 'chamka-khmer-8eb3b.firebaseapp.com',
    storageBucket: 'chamka-khmer-8eb3b.firebasestorage.app',
    measurementId: 'G-FLPXEW6DZ0',
  );

}