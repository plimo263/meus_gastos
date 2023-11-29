import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    double value = balance;
    String signal = '+';
    if (value < 0) {
      value *= -1;
      signal = '-';
    }
    return '$signal${UtilBrasilFields.obterReal(value)}';
  }

  TextStyle getFormatTextMoney() {
    final textTheme = GoogleFonts.novaScript();
    if (balance >= 0) {
      return textTheme.copyWith(
        color: Colors.green.shade800,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      );
    }

    return textTheme.copyWith(
      color: Colors.red.shade900,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    final styleMoney = getFormatTextMoney();
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
