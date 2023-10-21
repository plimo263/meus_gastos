import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/routes_app.dart';

import '../../widgets/logo.dart';

class _SplashString {
  static const title = 'Meus Gastos';
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _goToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(initialRouteApp);
    });
  }

  @override
  Widget build(BuildContext context) {
    _goToHome(context);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Logo(),
            SizedBox(height: 16),
            Text(
              _SplashString.title,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
