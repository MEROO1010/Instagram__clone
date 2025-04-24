import 'package:flutter/material.dart';
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

void main() {
  runApp(const InstagramCloneApp());
}

class InstagramCloneApp extends StatelessWidget {
  const InstagramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Instagram Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginView(),
          '/signup': (_) => SignupView(),
          '/feed': (_) => FeedView(),
          '/create-post': (_) => CreatePostView(),
          '/profile':
              (_) => ProfileView(userId: ''), // Replace with dynamic ID later
        },
      ),
    );
  }
}
