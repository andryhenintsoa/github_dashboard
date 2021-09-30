import 'package:flutter/material.dart';
import 'package:github_dashboard/ui/screen/home_screen.dart';
import 'package:github_dashboard/ui/screen/repo_screen.dart';
import 'package:github_dashboard/ui/screen/user_screen.dart';

class AppRouter {
  static final String initialRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case UserScreen.route:
        var data = settings.arguments as UserScreenArgument;
        return MaterialPageRoute(
          builder: (_) => UserScreen.withArgument(argument: data),
          settings: settings,
        );
      case RepoScreen.route:
        var data = settings.arguments as RepoScreenArgument;
        return MaterialPageRoute(
          builder: (_) => RepoScreen.withArgument(argument: data),
          settings: settings,
        );
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
