import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/interfaces/resource_paid.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class CardStatusResourcePaidWidget extends StatelessWidget {
  final List<ResourcePaid> resourcePaid;
  const CardStatusResourcePaidWidget({Key? key, required this.resourcePaid})
      : super(key: key);

  IconData getIcon() {
    if (resourcePaid is List<FinancialIncome>) {
      return Icons.trending_up;
    } else {
      return Icons.trending_down;
    }
  }

  Color getColor() {
    if (resourcePaid is List<FinancialIncome>) {
      return HexColor('#81C784');
    } else {
      return HexColor('#E57373');
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
    final total = resourcePaid.fold(
      0.0,
      (previousValue, element) => previousValue + element.value,
    );
    return UtilBrasilFields.obterReal(total);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Card(
        margin: EdgeInsets.zero,
        color: getColor(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                getIcon(),
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Text(
                '${getType()}: ${getSumValues()}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
