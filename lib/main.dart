import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/settings_provider.dart';
import 'services/auth_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint(
      'Firebase not configured for this platform (${kIsWeb ? "web" : defaultTargetPlatform}): $e',
    );
  }
  // Initialize AuthService to load any existing user session
  await AuthService.initialize();
  runApp(const AppProviders());
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => ProductProvider()..loadData()),

        ChangeNotifierProvider(create: (_) => FavoritesProvider()),

        ChangeNotifierProvider(create: (_) => SettingsProvider()..load()),

        ChangeNotifierProvider(create: (_) => CartProvider()),

        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MyApp(),
    );
  }
}
