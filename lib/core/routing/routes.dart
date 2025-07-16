import 'package:flutter/material.dart';
import 'package:online_exam/features/authentication/presentation/screens/sign_in_screen.dart';

/// Easy to add new routes by adding constants and cases
/// Centralized management of all app navigation

abstract class AppRoutes {
  // Routes
  static const String login = '/login';
  static const String signUp = '/signUp';

  // Route Generation
  static Route onGenerateRoute(RouteSettings settings) {
    /*
    This is the core of Flutter's named routing system
    RouteSettings settings contains the route name and any arguments passed during navigation
    Returns a Route object that Flutter uses to build the appropriate screen
    */
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(child: Text("No Page")),
              ), // Replace with your NotFoundPage widget
        );
    }
  }
}
