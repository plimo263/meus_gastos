import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/login/login_screen.dart';
import 'package:meus_gastos/utils/singleton/user_singleton.dart';

final _googleID = dotenv.env['GOOGLE_LOGIN_ID'];
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  clientId: _googleID,
);

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
      final userGoogle = _googleSignIn.currentUser;
      if (userGoogle != null) {
        redirectToHome(userGoogle);
      } else {
        redirectToLogin();
      }
    });
  }

  void redirectToHome(GoogleSignInAccount userGoogle) {
    final user = User(
      userGoogle.id,
      userGoogle.displayName ?? '',
      userGoogle.email,
      userGoogle.photoUrl ?? '',
    );
    UserSingleton(user);
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
