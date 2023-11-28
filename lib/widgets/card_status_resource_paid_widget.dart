import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/interfaces/resource_paid.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class CardStatusResourcePaidWidget extends StatelessWidget {
  final List<ResourcePaid> resourcePaid;
  const CardStatusResourcePaidWidget({super.key, required this.resourcePaid});

  IconData getIcon() {
    if (resourcePaid is List<FinancialIncome>) {
      return Icons.trending_up;
    } else {
      return Icons.trending_down;
    }
  }

  Color getColor() {
    if (resourcePaid is List<FinancialIncome>) {
      return HexColor('#2E7D32');
    } else {
      return HexColor('#C62828');
    }
  }

  String getType() {
    if (resourcePaid is List<FinancialIncome>) {
      return 'Receitas';
    } else {
      return 'Despesas';
    }
  }

  String getSumValues() {
    String signal = '';
    double total = resourcePaid.fold(
      0.0,
      (previousValue, element) => previousValue + element.value,
    );

    if (total > 0 && resourcePaid is List<SpedingMoney>) {
      signal = '-';
    } else if (total > 0 && resourcePaid is List<FinancialIncome>) {
      signal = '+';
    }
    //
    return '$signal${UtilBrasilFields.obterReal(total)}';
  }

  TextStyle getFormatTextMoney() {
    final textTheme = GoogleFonts.novaScript();
    if (resourcePaid is List<FinancialIncome>) {
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
      dense: true,
      leading: CircleAvatar(
        backgroundColor: getColor(),
        child: Icon(
          getIcon(),
          color: Colors.white,
        ),
      ),
      title: Text(getType()),
      trailing: AutoSizeText(
        getSumValues(),
        style: styleMoney,
      ),
    );
  }
}
