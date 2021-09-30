import 'package:flutter/material.dart';
import 'package:github_dashboard/core/service_locator.dart';
import 'package:github_dashboard/ui/app_router.dart';
import 'package:github_dashboard/ui/styling.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Dashboard',
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: theme(),
    );
  }
}
