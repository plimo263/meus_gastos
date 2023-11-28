import 'package:flutter/material.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: const [
          AvatarUserWidget(),
          PopupMenuWidget(),
        ],
      ),
      body: const Center(child: Text('Dashboard')),
    );
  }
}
