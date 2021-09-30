import 'package:flutter/material.dart';
import 'package:github_dashboard/ui/screen/home_screen.dart';

class AppRouter {
  static final String initialRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
