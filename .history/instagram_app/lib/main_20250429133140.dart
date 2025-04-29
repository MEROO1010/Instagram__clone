import 'package:flutter/material.dart';
import 'package:instagram_app/views/home_view.dart';
import 'package:instagram_app/views/login_view.dart';
import 'package:instagram_app/views/signup_view.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const LoginView(),
        '/signup': (_) => const SignupView(),
        '/home': (_) => const HomeView(),
      },
    );
  }
}
