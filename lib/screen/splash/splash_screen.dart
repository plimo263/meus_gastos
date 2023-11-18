import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/login/login_screen.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      LoginSingleton().isAuth().then((isAuth) {
        if (isAuth) {
          redirectToHome();
        } else {
          redirectToLogin();
        }
      });
    });
  }

  void redirectToHome() {
    // Avancar a tela de home
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  void redirectToLogin() {
    // Avancar a tela de login
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      body: Center(
        child: Image.asset(logoAsset),
      ),
    );
  }
}
