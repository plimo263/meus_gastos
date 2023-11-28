import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_add_upd_screen.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/credit_card_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  void onAddCreditCard(BuildContext context) {
    Navigator.of(context).pushNamed(CreditCardAddUpdScreen.routeName);
  }

  void onUpdateCreditCard(BuildContext context, CreditCard creditCard) {
    Navigator.of(context).pushNamed(
      CreditCardAddUpdScreen.routeName,
      arguments: creditCard,
    );
  }

  //
  Future<bool?> onDelete(
      DismissDirection direction, CreditCard creditCard) async {
    if (direction == DismissDirection.startToEnd) {
      return showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.creditCardTitleDelete,
              ),
              content: Text.rich(
                TextSpan(
                  text: AppLocalizations.of(context)!.creditCardBodyDelete1,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.creditCardBodyDelete2,
                      style: const TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.creditCardBodyDelete3,
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    AppLocalizations.of(context)!
                        .creditCardLabelBtnCancelDelete,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CreditCardProviderController>(context,
                            listen: false)
                        .del(creditCard);
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    AppLocalizations.of(context)!
                        .creditCardLabelBtnConfirmDelete,
                  ),
                ),
              ],
            );
          });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.creditCardTitle,
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
              padding: const EdgeInsets.all(8.0),
              itemCount: creditCardList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: Key(creditCardList[index].id.toString()),
                  background: Card(
                    color: Colors.red.shade800,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)!
                                .creditCardBodyBackCardDelete,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) =>
                      onDelete(direction, creditCardList[index]),
                  child: CreditCardWidget(
                    creditCard: creditCardList[index],
                    onEdit: () => onUpdateCreditCard(
                      context,
                      creditCardList[index],
                    ),
                  ),
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
