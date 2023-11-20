import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/category/new_category_screen.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/login/login_screen.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NewCategoryScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => NewCategoryScreen(
          type: settings.arguments as String,
        ),
      );
    default:
      break;
  }

  return null;
}
