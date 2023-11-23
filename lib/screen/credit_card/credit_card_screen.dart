import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_add_upd_screen.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/credit_card_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

class _CreditCardStr {
  static const title = 'Cartões';
  static const titleDelete = 'Excluir Cartão';
  static const bodyDelete1 = 'Deseja realmente ';
  static const bodyDelete2 = 'excluir';
  static const bodyDelete3 = ' ? Esta ação não pode ser desfeita';
  static const labelBtnCancelDelete = 'CANCELAR';
  static const labelBtnConfirmDelete = 'CONFIRMAR';
  static const bodyBackCardDelete = 'EXCLUIR CARTÃO';
}

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

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
              title: const Text(_CreditCardStr.titleDelete),
              content: const Text.rich(
                TextSpan(
                  text: _CreditCardStr.bodyDelete1,
                  children: [
                    TextSpan(
                      text: _CreditCardStr.bodyDelete2,
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: _CreditCardStr.bodyDelete3,
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    _CreditCardStr.labelBtnCancelDelete,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CreditCardProviderController>(context,
                            listen: false)
                        .del(creditCard);
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    _CreditCardStr.labelBtnConfirmDelete,
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
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: Key(creditCardList[index].id.toString()),
                  background: Card(
                    color: Colors.red.shade800,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _CreditCardStr.bodyBackCardDelete,
                            style: TextStyle(
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
