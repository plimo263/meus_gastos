import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
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
    double total = resourcePaid.fold(
      0.0,
      (previousValue, element) => previousValue + element.value,
    );
    if (total > 0 && resourcePaid is List<SpedingMoney>) {
      total = total * -1;
    }
    return UtilBrasilFields.obterReal(total);
  }

  @override
  Widget build(BuildContext context) {
    final styleMoney = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 16,
          color: Colors.black87,
        );
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
      trailing: Text(
        getSumValues(),
        style: styleMoney,
      ),
    );
  }
}
