import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/utils/singleton/user_singleton.dart';

final _googleID = dotenv.env['GOOGLE_LOGIN_ID'];
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  serverClientId: _googleID,
);

/// Classe de login/logout para acesso simples no App
class LoginSingleton {
  static final instance = LoginSingleton._internal();
  UserSingleton? _userSingleton;

  LoginSingleton._internal();

  factory LoginSingleton() {
    return instance;
  }

  UserSingleton? get user {
    return _userSingleton;
  }

  /// Verifica se o usuario esta logado no sistema
  Future<bool> isAuth() async {
    final isAuthUser = await _googleSignIn.isSignedIn();
    if (isAuthUser) {
      if (user == null) {
        final userGoogle = await _googleSignIn.signInSilently();
        if (userGoogle != null) {
          _createSingleUser(userGoogle);
        }
      }
    }
    return isAuthUser;
  }

  /// Metodo interno que instancia o singleUser
  void _createSingleUser(GoogleSignInAccount userGoogle) {
    final user = User(
      userGoogle.id,
      userGoogle.displayName ?? '',
      userGoogle.email,
      userGoogle.photoUrl ?? '',
    );
    _userSingleton = UserSingleton(user);
  }

  /// Inicia o procedimento de login via google
  Future<bool> login() async {
    final currentUser = await _googleSignIn.signIn();
    if (currentUser != null) {
      _createSingleUser(currentUser);
      return true;
    } else {
      return false;
    }
  }

  /// Finaliza o login via google deslogando o usuario
  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
  }
}
