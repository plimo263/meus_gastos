import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/category/category_screen.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_screen.dart';
import 'package:meus_gastos/screen/dashboard/dashboard_screen.dart';
import 'package:meus_gastos/screen/my_speding/my_speding_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const _screens = <Widget>[
  MySpedingScreen(),
  CategoryScreen(),
  CreditCardScreen(),
  DashboardScreen(),
];
//

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTap(int value) {
    _currentIndex = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigatonCustom(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class BottomNavigatonCustom extends StatelessWidget {
  final int currentIndex;
  final void Function(int value) onTap;
  const BottomNavigatonCustom(
      {super.key, required this.currentIndex, required this.onTap});

  List<Map<String, dynamic>> getBottomItems(BuildContext context) {
    final refStr = AppLocalizations.of(context);
    return [
      {'icon': Icons.wallet, 'name': refStr!.homeBudget},
      {'icon': Icons.category, 'name': refStr.homeCategory},
      {'icon': Icons.credit_card, 'name': refStr.homeCard},
      {'icon': Icons.bar_chart, 'name': refStr.homeDashboard},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      currentIndex: currentIndex,
      items: getBottomItems(context).map<BottomNavigationBarItem>((e) {
        return BottomNavigationBarItem(
          icon: Icon(
            e['icon'] as IconData,
          ),
          label: e['name'] as String,
        );
      }).toList(),
    );
  }
}
