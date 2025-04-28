import 'package:flutter/material.dart';
import 'package:instagram_app/views/home_view.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/auth_provider.dart';
import 'providers/post_provider.dart';
import 'providers/comment_provider.dart';
import 'providers/user_provider.dart';

// Views
import 'views/auth/login_view.dart';
import 'views/auth/signup_view.dart';
import 'views/home/feed_view.dart';
import 'views/profile/profile_view.dart';
import 'views/home/create_post_view.dart';

// Utils
import 'utils/constants.dart';
import 'views/splash_screen.dart'; // Import splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        routes: {
          '/login': (context) => const LoginView(),
          '/signup': (context) => SignupView(),
          '/home': (context) => const HomeView(),
        },
        home: const SplashScreen(), // Show SplashScreen first
      ),
    );
  }
}
