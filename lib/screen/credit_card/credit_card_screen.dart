import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_add_screen.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/credit_card_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

class _CreditCardStr {
  static const title = 'Cartões';
}

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  void onAddCreditCard(BuildContext context) {
    Navigator.of(context).pushNamed(CreditCardAddScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          _CreditCardStr.title,
        ),
        actions: const [
          AvatarUserWidget(),
          PopupMenuWidget(),
        ],
      ),
      body: Consumer<CreditCardProviderController>(
        builder: (context, value, child) {
          final creditCardList = value.getAll();

          return ListView.builder(
              itemCount: creditCardList.length,
              itemBuilder: (context, index) {
                return CreditCardWidget(
                  creditCard: creditCardList[index],
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAddCreditCard(context);
        },
        child: const Icon(
          Icons.add_card,
        ),
      ),
    );
  }
}
