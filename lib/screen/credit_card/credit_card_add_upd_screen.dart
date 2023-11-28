import 'package:flutter/material.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditCardAddUpdScreen extends StatelessWidget {
  final CreditCard? creditCard;
  static const routeName = 'add_credit_card';
  const CreditCardAddUpdScreen({
    super.key,
    this.creditCard,
  });

  String getTitle(BuildContext context) {
    final refStr = AppLocalizations.of(context);
    if (creditCard != null) {
      return refStr!.creditCardAddUpdEdit;
    } else {
      return refStr!.creditCardAddUpdCreate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle(context)),
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
