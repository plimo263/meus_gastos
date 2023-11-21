import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_form.dart';

class CreditCardAddScreen extends StatelessWidget {
  static const routeName = 'add_credit_card';
  const CreditCardAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo cartão'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CreditCardForm(),
      ),
    );
  }
}
