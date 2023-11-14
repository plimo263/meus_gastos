import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
    // ID de web
    clientId:
        '881286680803-sq02s98vi3r72ch9akac2ljo247onpjf.apps.googleusercontent.com',
    scopes: [
      'email',
    ]);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> loginGoogle() async {
    final user = _googleSignIn.currentUser;
    print(user);
    if (user == null) {
      final response = await _googleSignIn.signIn();
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login com o google'),
            ElevatedButton(
              onPressed: () {
                loginGoogle();
              },
              child: Text('Login com o google'),
            ),
          ],
        ),
      ),
    );
  }
}
