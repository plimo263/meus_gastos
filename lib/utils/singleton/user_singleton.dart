import 'package:meus_gastos/model/user.dart';

class UserSingleton {
  static UserSingleton? _instance;
  User? _user;

  UserSingleton._internal();

  factory UserSingleton(User user) {
    if (_instance != null) {
      _instance!._user = user;
      return _instance!;
    }
    _instance = UserSingleton._internal();
    _instance!._user = user;
    return _instance!;
  }

  User? get user {
    return _user;
  }
}
