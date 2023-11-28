import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';
import 'package:provider/provider.dart';

class AvatarUserWidget extends StatelessWidget {
  const AvatarUserWidget({super.key});

  bool isUserAuth() {
    if (LoginSingleton().user != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProviderController>(
      builder: (context, userProv, child) {
        final user = userProv.getUser();

        return CircleAvatar(
          maxRadius: 16,
          backgroundImage: user != null ? NetworkImage(user.avatar) : null,
        );
      },
    );
  }
}
