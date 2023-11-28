import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class BalanceWidget extends StatelessWidget {
  final double balance;
  const BalanceWidget({
    super.key,
    required this.balance,
  });

  IconData getIcon() {
    return Icons.account_balance_wallet;
  }

  Color getColor() {
    return HexColor('#1565C0');
  }

  String getType() {
    return 'Saldo';
  }

  String getValueFormat() {
    return UtilBrasilFields.obterReal(balance);
  }

  @override
  Widget build(BuildContext context) {
    final styleMoney = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 16,
          color: Colors.black87,
        );
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: getColor(),
        child: Icon(
          getIcon(),
          color: Colors.white,
        ),
      ),
      title: Text(getType()),
      trailing: Text(
        getValueFormat(),
        style: styleMoney,
      ),
    );
  }
}
