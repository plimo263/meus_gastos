import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/constants/strings.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/utils/singleton/config_singleton.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';
import 'package:provider/provider.dart';

class _LoginScreenStr {
  static const labelBtn = 'LOGAR COM O GOOGLE';
}

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  Future<void> loginGoogle() async {
    final isLogin = await LoginSingleton().login();
    if (isLogin) {
      redirectToHome();
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(logoAsset)
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                    delay: 2000.ms,
                    duration: 1500.ms,
                  ),
              const SizedBox(width: 8),
              const Text(
                titleAppStr,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                  ),
                  onPressed: () {
                    loginGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        googleAsset,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      const Text(
                        _LoginScreenStr.labelBtn,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
