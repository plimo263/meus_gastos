import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';
import 'package:provider/provider.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        onSelected: (value) {
          switch (value) {
            case 1:
              LoginSingleton().logout().then((_) {
                Provider.of<UserProviderController>(context, listen: false)
                    .logout();
                Provider.of<CategoryProviderController>(context, listen: false)
                    .delAll();
                Provider.of<CreditCardProviderController>(context,
                        listen: false)
                    .delAll();
                Provider.of<ResourcePaidProviderController>(context,
                        listen: false)
                    .delAll();
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
          return const [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
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
