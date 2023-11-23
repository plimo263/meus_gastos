import 'package:flutter/material.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_form.dart';

class CreditCardAddUpdScreen extends StatelessWidget {
  final CreditCard? creditCard;
  static const routeName = 'add_credit_card';
  const CreditCardAddUpdScreen({
    Key? key,
    this.creditCard,
  }) : super(key: key);

  String getTitle() {
    if (creditCard != null) {
      return 'Editar cartão';
    } else {
      return 'Novo cartão';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: CreditCardForm(
          creditCard: creditCard,
        ),
      ),
    );
  }
}
