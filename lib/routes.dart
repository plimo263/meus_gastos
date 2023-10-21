import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/routes_app.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/initial_screen.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  splashRouteApp: (context) {
    return const SplashScreen();
  },
  initialRouteApp: (context) {
    return const InitialScreen();
  },
  homeRouteApp: (context) {
    return const HomeScreen();
  }
};
