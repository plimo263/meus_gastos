import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/utils/categories_default.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/category_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

const _typeCategories = [
  {'text': 'DESPESAS', 'icon': Icons.trending_down},
  {'text': 'RECEITAS', 'icon': Icons.trending_up}
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _spedingList = [];
  List<Category> _incomeList = [];
  @override
  void initState() {
    super.initState();
    final Map<String, List<Category>> categoriesDefault =
        getCategoriesDefault();
    _spedingList.addAll(categoriesDefault['speding'] as List<Category>);
    _incomeList.addAll(categoriesDefault['income'] as List<Category>);

    Future.microtask(() {
      _spedingList.addAll(
        Provider.of<CategoryProviderController>(context).getAll(),
      );
      setState(() {});
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _typeCategories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categoria'),
          actions: const [
            AvatarUserWidget(),
            PopupMenuWidget(),
          ],
          bottom: TabBar(
              tabs: _typeCategories
                  .map<Tab>((e) => Tab(
                        text: e['text'] as String,
                        icon: Icon(e['icon'] as IconData),
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
          _Spedings(
            spendings: _spedingList,
          ),
          const _Incomes()
        ]),
      ),
    );
  }
}

class _Incomes extends StatelessWidget {
  const _Incomes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class _Spedings extends StatelessWidget {
  final List<Category> spendings;
  const _Spedings({Key? key, required this.spendings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: spendings.map<Widget>((e) {
        return CategoryWidget(category: e);
      }).toList(),
    );
  }
}
