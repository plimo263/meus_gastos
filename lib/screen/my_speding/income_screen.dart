import 'package:flutter/material.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/screen/my_speding/form_income.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncomeScreen extends StatelessWidget {
  final FinancialIncome? income;
  static const routename = 'maintenance_income';
  const IncomeScreen({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.incomeScreenTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FormIncome(income: income),
      ),
    );
  }
}
