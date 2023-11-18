import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        onSelected: (value) {
          switch (value) {
            case 1:
              LoginSingleton().logout().then((_) {
                Navigator.of(context).pushReplacementNamed(
                  SplashScreen.routeName,
                );
              });
              break;
            default:
              break;
          }
        },
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4),
                  Text('SAIR DO APP')
                ],
              ),
            )
          ];
        });
  }
}
