import 'package:flutter/material.dart';
import 'package:instagram_app/views/login_view.dart';
import 'package:instagram_app/views/signup_view.dart';
import 'views/home_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
    }
  }
}
