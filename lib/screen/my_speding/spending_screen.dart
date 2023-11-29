import 'package:flutter/material.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meus_gastos/screen/my_speding/form_speding.dart';

class SpendingScreen extends StatelessWidget {
  final SpedingMoney? speding;
  static const routename = 'maintenance_spending';
  const SpendingScreen({super.key, required this.speding});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.spendingScreenTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FormSpeding(speding: speding),
      ),
    );
  }
}
