import 'package:flutter/material.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';

class AvatarUserWidget extends StatelessWidget {
  const AvatarUserWidget({Key? key}) : super(key: key);

  bool isUserAuth() {
    if (LoginSingleton().user != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 16,
      backgroundImage: isUserAuth()
          ? NetworkImage(LoginSingleton().user!.user!.avatar)
          : null,
    );
  }
}
