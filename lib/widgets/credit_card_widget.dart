import 'package:flutter/material.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCard creditCard;
  const CreditCardWidget({
    Key? key,
    required this.creditCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: HexColor(creditCard.color),
          child: const Icon(
            Icons.credit_card,
            color: Colors.white,
          ),
        ),
        title: Text(creditCard.name),
        subtitle: Text(creditCard.getValueMonetary()),
      ),
    );
  }
}
