import 'package:flutter/material.dart';
import 'package:meus_gastos/widgets/income.dart';
import 'package:meus_gastos/widgets/speding.dart';

class _HomeString {
  static const title = 'Meus Gastos';
  static const speding = 'Despesas';
  static const income = 'Receitas';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_HomeString.title),
        bottom: const PreferredSize(
          preferredSize: Size(
            double.maxFinite,
            24,
          ),
          child: _AppBarController(),
        ),
      ),
      body: Column(
        children: [
          _ResumeInfo(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ResumeInfo extends StatelessWidget {
  const _ResumeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Speding()),
            Expanded(child: Income()),
          ],
        ),
        const SizedBox(
          width: double.maxFinite,
          height: 32,
          child: Card(
            elevation: 3,
            child: Text('Saldo -R\$ 500,00'),
          ),
        )
      ],
    );
  }
}

class _AppBarController extends StatelessWidget {
  const _AppBarController({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        const Expanded(
            child: Text(
          '1 a 31 outubro de 2023',
          textAlign: TextAlign.center,
        )),
        IconButton(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ],
    );
  }
}
