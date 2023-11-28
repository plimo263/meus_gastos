import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/category/category_screen.dart';
import 'package:meus_gastos/screen/credit_card/credit_card_screen.dart';
import 'package:meus_gastos/screen/dashboard/dashboard_screen.dart';
import 'package:meus_gastos/screen/my_speding/my_speding_screen.dart';

const _screens = <Widget>[
  MySpedingScreen(),
  CategoryScreen(),
  CreditCardScreen(),
  DashboardScreen(),
];
//
final List<Map<String, dynamic>> _bottomItems = [
  {'icon': Icons.wallet, 'name': 'Orçamento'},
  {'icon': Icons.category, 'name': 'Categoria'},
  {'icon': Icons.credit_card, 'name': 'Cartão'},
  {'icon': Icons.bar_chart, 'name': 'Dashboard'},
];

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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      currentIndex: currentIndex,
      items: _bottomItems.map<BottomNavigationBarItem>((e) {
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
