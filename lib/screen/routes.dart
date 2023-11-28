import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/screen/category/new_category_screen.dart';
import 'package:meus_gastos/screen/category/update_category_screen.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_add_upd_screen.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/login/login_screen.dart';
import 'package:meus_gastos/screen/my_speding/income_screen.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
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
    case CreditCardAddUpdScreen
          .routeName: // Para editar/adicionar um cartão de crédito
      CreditCard? creditCard;
      if (settings.arguments != null) {
        creditCard = settings.arguments as CreditCard;
      }
      return MaterialPageRoute(
        builder: (context) => CreditCardAddUpdScreen(
          creditCard: creditCard,
        ),
      );
    case IncomeScreen.routename:
      FinancialIncome? income;
      if (settings.arguments != null) {
        income = settings.arguments as FinancialIncome;
      }
      return MaterialPageRoute(builder: (ctx) => IncomeScreen(income: income));
    default:
      break;
  }

  return null;
}
