import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/category/category_screen.dart';
import 'package:meus_gastos/screen/dashboard/dashboard_screen.dart';
import 'package:meus_gastos/screen/home/home_screen.dart';
import 'package:meus_gastos/screen/preview/preview_screen.dart';

const pages = [
  HomeScreen(),
  CategoryScreen(),
  DashboardScreen(),
  PreviewScreen(),
];

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: _BottomNavigationApp(
        onTap: _onTap,
        currentIndex: _currentIndex,
      ),
    );
  }
}

class _BottomNavigationApp extends StatelessWidget {
  final void Function(int index) onTap;
  final int currentIndex;

  _BottomNavigationApp(
      {super.key, required this.onTap, required this.currentIndex});

  final _optionsBottom = [
    {'text': 'Home', 'icon': Icons.home},
    {'text': 'Categorias', 'icon': Icons.build},
    {'text': 'Dashboard', 'icon': Icons.dashboard},
    {'text': 'Previsão', 'icon': Icons.preview},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: _optionsBottom.map<BottomNavigationBarItem>((e) {
        return BottomNavigationBarItem(
          icon: Icon(e['icon'] as IconData),
          label: e['text'] as String,
        );
      }).toList(),
    );
  }
}
