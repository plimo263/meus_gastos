import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/constants/strings.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';

class _LoginScreenStr {
  static const labelBtn = 'LOGAR COM O GOOGLE';
}

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  const LoginScreen({Key? key}) : super(key: key);

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
    // Avancar a tela de home
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
