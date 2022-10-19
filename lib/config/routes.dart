import 'package:flutter/material.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/screens/loginpage.dart';
import 'package:newsapp/screens/signuppage.dart';

import '../screens/homepage.dart';

class Router{
  static const String homePage = '/homePage';
  static const String authPage = '/authPage';
  static const String signUpPage = '/signUpPage';
  static const String loginPage = '/loginPage';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case authPage:
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      case signUpPage:
        return MaterialPageRoute(builder: (context) => const SignupPage());
      case loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}