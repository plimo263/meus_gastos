import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/login/login_screen.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/utils/singleton/config_singleton.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash';
  const SplashScreen({super.key});

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
    final configSing = ConfigSingleton();
    final user = LoginSingleton().user!.user as User;

    Provider.of<UserProviderController>(context, listen: false)
        .init(user)
        .then((_) {
      // Recupera o usuario instanciado
      final inUser = Provider.of<UserProviderController>(context, listen: false)
          .getUser() as User;
      configSing.init(inUser).then((_) {
        configSing.initRepositories(context, inUser).then((_) {
          // Avancar a tela de home
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
      }).catchError((err) {
        // Algum erro alerta ao usuário.
        AppSnackBar().snack(err.toString());
      });
    });
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
