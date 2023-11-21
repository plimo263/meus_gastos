import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/screen/category/new_category_screen.dart';
import 'package:meus_gastos/screen/category/update_category_screen.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_add_screen.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/login/login_screen.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  CreditCardAddScreen.routeName: (context) => const CreditCardAddScreen(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NewCategoryScreen.routeName: // Nova categoria
      return MaterialPageRoute(
        builder: (context) => NewCategoryScreen(
          type: settings.arguments as String,
        ),
      );
    case UpdateCategoryScreen.routeName: // Atualizando categoria existente
      final category = settings.arguments as Category;
      return MaterialPageRoute(
        builder: (context) => UpdateCategoryScreen(
          type: category.type,
          category: category,
        ),
      );
    default:
      break;
  }

  return null;
}
