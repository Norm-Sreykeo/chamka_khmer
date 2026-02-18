// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'providers/auth_provider.dart';
// import 'providers/catalog_provider.dart';
// import 'screens/loading_screen.dart';
// import 'screens/login/login_screen.dart';
// import 'screens/main_nav_screen.dart';
// import 'screens/register_screen.dart';


// void main() {
//   runApp(const ChamkaKhmerApp());
// }

// class ChamkaKhmerApp extends StatelessWidget {
//   const ChamkaKhmerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => CatalogProvider()),
//       ],
//       child: MaterialApp(
//         title: 'ចម្ការខ្មែរ',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//           scaffoldBackgroundColor: const Color(0xFFF7F7F2),
//           textTheme: GoogleFonts.siemreapTextTheme(Theme.of(context).textTheme),
//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Color(0xFFB7D38B)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Color(0xFFB7D38B)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Color(0xFF7AA12B), width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 12,
//             ),
//           ),
//         ),
//         routes: {
//           '/login': (_) => const LoginScreen(),
//           '/register': (_) => const RegisterScreen(),
//           '/main': (_) => const MainNavScreen(),
//         },
//         home: const LoadingScreen(),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/catalog_provider.dart';
import 'screens/loading_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/main_nav_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const ChamkaKhmerApp());
}

class ChamkaKhmerApp extends StatelessWidget {
  const ChamkaKhmerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CatalogProvider()),
      ],
      child: MaterialApp(
        title: 'ចម្ការខ្មែរ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: const Color(0xFFF8F5ED),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
            secondary: const Color(0xFFF1A567),
            background: const Color(0xFFF8F5ED),
          ),
          textTheme: GoogleFonts.notoSansKhmerTextTheme(
            Theme.of(context).textTheme,
          ).apply(
            bodyColor: Colors.black87,
            displayColor: Colors.black87,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF7AA12B),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 1.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB7D38B)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB7D38B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF7AA12B), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/main': (_) => const MainNavScreen(),
        },
        home: const LoadingScreen(),
      ),
    );
  }
}