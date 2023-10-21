import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/routes_app.dart';
import 'package:meus_gastos/routes.dart';
import 'package:meus_gastos/themes/theme_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: splashRouteApp,
      routes: routes,
    );
  }
}
