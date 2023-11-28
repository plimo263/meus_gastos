import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class _CreditCardStr {
  static const dayGoodofPayment = 'Fechamento ';
  static const dayPayment = 'Vencimento ';
}

class CreditCardWidget extends StatelessWidget {
  final CreditCard creditCard;
  final VoidCallback? onEdit;
  const CreditCardWidget({
    super.key,
    required this.creditCard,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onEdit,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: HexColor(creditCard.color),
            child: const Icon(
              Icons.credit_card,
              color: Colors.white,
              size: 28,
            ),
          ),
          title: _Title(creditCard: creditCard),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: _Subtitle(creditCard: creditCard),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final CreditCard creditCard;
  const _Title({required this.creditCard});

  @override
  Widget build(BuildContext context) {
    final moneyStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(creditCard.name),
        AutoSizeText(
          creditCard.getValueMonetary(),
          maxLines: 1,
          style: moneyStyle,
        ),
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  final CreditCard creditCard;
  const _Subtitle({required this.creditCard});

  @override
  Widget build(BuildContext context) {
    final stylelabel = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.black87,
        );
    final styleValue = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.blue.shade500,
          fontWeight: FontWeight.w600,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText.rich(
          TextSpan(
            text: _CreditCardStr.dayGoodofPayment,
            style: stylelabel,
            children: [
              TextSpan(
                text: creditCard.dayGoodBuy.toString(),
                style: styleValue,
              ),
            ],
          ),
          maxLines: 1,
        ),
        AutoSizeText.rich(
          TextSpan(
            text: _CreditCardStr.dayPayment,
            style: stylelabel,
            children: [
              TextSpan(
                text: creditCard.dayOfPayment.toString(),
                style: styleValue,
              ),
            ],
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
