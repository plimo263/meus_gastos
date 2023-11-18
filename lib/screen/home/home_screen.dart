import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';

final _googleID = dotenv.env['GOOGLE_LOGIN_ID'];
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  clientId: _googleID,
);

class HomeScreen extends StatelessWidget {
  static const routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('olá seja bem vindo'),
            ElevatedButton(
              onPressed: () {
                _googleSignIn.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed(
                    SplashScreen.routeName,
                  );
                });
              },
              child: const Text('SAIR DO APP'),
            ),
          ],
        ),
      ),
    );
  }
}
