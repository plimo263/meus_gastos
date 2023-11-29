import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/interfaces/resource_paid.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/screen/my_speding/income_screen.dart';
import 'package:meus_gastos/screen/my_speding/spending_screen.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/background_delete_widget.dart';
import 'package:meus_gastos/widgets/balance_widget.dart';
import 'package:meus_gastos/widgets/card_animator_widget.dart';
import 'package:meus_gastos/widgets/card_status_resource_paid_widget.dart';
import 'package:meus_gastos/widgets/fab_custom_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:meus_gastos/widgets/resource_paid_widget.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class MySpedingScreen extends StatefulWidget {
  const MySpedingScreen({super.key});

  @override
  State<MySpedingScreen> createState() => _MySpedingScreenState();
}

class _MySpedingScreenState extends State<MySpedingScreen> {
  void _onAddIncome() {
    Navigator.of(context).pushNamed(IncomeScreen.routename);
  }

  void _onAddSpeding() {
    Navigator.of(context).pushNamed(SpendingScreen.routename);
  }

  // Edita o valor de um recurso, seja de entrada ou de saida
  void onEditResource<ResourcePaid>(ResourcePaid value) {
    if (value is FinancialIncome) {
      Navigator.of(context).pushNamed(IncomeScreen.routename, arguments: value);
    }
  }

  // Exclui o recurso
  Future<bool?> onDelete(
    DismissDirection direction,
    ResourcePaid resourcePaid,
    BuildContext context,
  ) async {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text(AppLocalizations.of(context)!.mySpendingScreenTitleDelete),
            content: Text(
                AppLocalizations.of(context)!.mySpendingScreenContentDelete),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  AppLocalizations.of(context)!.mySpendingScreenLabelBtnCancel,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<ResourcePaidProviderController>(context,
                          listen: false)
                      .del(resourcePaid);

                  Navigator.of(context).pop(true);
                },
                child: Text(AppLocalizations.of(context)!
                    .mySpendingScreenLabelBtnConfirm),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final styleDateSection = GoogleFonts.orbit(
      fontSize: 20,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleApp),
        bottom: PreferredSize(
          preferredSize: const Size(
            double.maxFinite,
            32,
          ),
          child: ControlSwitchMonth(
            title: 'Novembro / 2023',
            onTap: (direction) {},
          ),
        ),
        actions: const [
          AvatarUserWidget(),
          PopupMenuWidget(),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _BoardInfoMain(),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Consumer<ResourcePaidProviderController>(
              builder: (context, value, child) {
                final items = value.getAll();
                return GroupedListView(
                    padding: const EdgeInsets.all(8),
                    elements: items,
                    groupBy: (element) => element.getDateRegister(),
                    groupSeparatorBuilder: (String groupValue) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: AutoSizeText(
                            groupValue,
                            style: styleDateSection,
                          ),
                        ),
                    itemBuilder: (context, ResourcePaid item) {
                      int id = 0;
                      if (item is FinancialIncome) {
                        id = item.id;
                      } else {
                        id = (item as SpedingMoney).id;
                      }

                      return Dismissible(
                        key: Key(id.toString()),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) =>
                            onDelete(direction, item, context),
                        background: const BackgroundDeleteWidget(),
                        child: ResourcePaidWidget(
                          resourcePaid: item,
                          onTap: onEditResource,
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FabCustomWidget(children: [
        SpeedDialChild(
          backgroundColor: Colors.green.shade900,
          child: const Icon(Icons.trending_up),
          label: AppLocalizations.of(context)!.mySpendingScreenLabelBtnIncome,
          onPressed: _onAddIncome,
        ),
        SpeedDialChild(
          backgroundColor: Colors.red.shade900,
          child: const Icon(
            Icons.trending_down,
          ),
          label: AppLocalizations.of(context)!.mySpendingScreenLabelBtnSpending,
          onPressed: _onAddSpeding,
        ),
      ]),
    );
  }
}

enum DirectionSwitch {
  prev,
  next,
}

class ControlSwitchMonth extends StatelessWidget {
  final String title;
  final void Function(DirectionSwitch direction) onTap;
  const ControlSwitchMonth({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              onTap(DirectionSwitch.prev);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          AutoSizeText(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              onTap(DirectionSwitch.next);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _BoardInfoMain extends StatelessWidget {
  const _BoardInfoMain();

  @override
  Widget build(BuildContext context) {
    return Consumer<ResourcePaidProviderController>(builder: (ctx, value, _) {
      final spendings = <SpedingMoney>[];
      final incomes = <FinancialIncome>[];

      value.getAll().forEach((element) {
        if (element is SpedingMoney) {
          spendings.add(element);
        } else {
          incomes.add(element as FinancialIncome);
        }
      });
      // Calcula o saldo do mês
      double totalSpeding =
          spendings.fold(0.0, (previous, element) => element.value + previous);
      double totalIncome =
          incomes.fold(0.0, (previous, element) => element.value + previous);

      double saldo = totalIncome - totalSpeding;

      return CardAnimatorWidget(
        title: AppLocalizations.of(context)!.mySpendingScreenTitleBoardMain,
        children: [
          const Divider(),
          CardStatusResourcePaidWidget(resourcePaid: incomes),
          const Divider(),
          CardStatusResourcePaidWidget(resourcePaid: spendings),
          const Divider(),
          BalanceWidget(balance: saldo),
        ],
      );
    });
  }
}
