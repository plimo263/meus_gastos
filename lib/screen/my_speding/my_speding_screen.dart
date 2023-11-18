import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/strings.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/card_status_resource_paid_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';

class MySpedingScreen extends StatelessWidget {
  const MySpedingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(titleAppStr),
        bottom: PreferredSize(
          preferredSize: const Size(
            double.maxFinite,
            32,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const AutoSizeText(
                  'Novembro / 2023',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: const [
          AvatarUserWidget(),
          PopupMenuWidget(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            SizedBox(
              width: double.maxFinite,
              child: _BoardInfoMain(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BoardInfoMain extends StatelessWidget {
  const _BoardInfoMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child:
              CardStatusResourcePaidWidget(resourcePaid: <FinancialIncome>[]),
        ),
        SizedBox(width: 4),
        Expanded(
          child: CardStatusResourcePaidWidget(resourcePaid: <SpedingMoney>[]),
        ),
      ],
    );
  }
}
