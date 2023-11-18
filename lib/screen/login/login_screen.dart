import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/constants/strings.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/utils/singleton/user_singleton.dart';

import '../../model/user.dart';

final _googleID = dotenv.env['GOOGLE_LOGIN_ID'];
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  clientId: _googleID,
);

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
    final response = await _googleSignIn.signIn();
    if (response != null) {
      redirectToHome(response);
    }
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
              Image.asset(logoAsset),
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
                      Text(
                        _LoginScreenStr.labelBtn,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 14,
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
