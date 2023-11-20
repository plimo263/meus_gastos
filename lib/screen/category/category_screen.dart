import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/screen/category/new_category_screen.dart';
import 'package:meus_gastos/screen/category/update_category_screen.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/category_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

class _CategoryScreenStr {
  static const title = 'Categoria';
  static const titleTab1 = 'DESPESAS';
  static const titleTab2 = 'RECEITAS';
  static const errorNoPersmissionDelete = 'Este ícone não pode ser excluído';
  static const titleDelete = 'Excluir Categoria';
  static const contentDelete =
      'Deseja realmente excluir esta categoria ? Ela não poderá ser recuperar e todas as despesas/receitas vinculadas com ela ficará com o icone OUTROS.';
  static const labelBtnCancel = 'CANCELAR';
  static const labelBtnConfirm = 'CONFIRMAR';
}

const _typeCategories = [
  {'text': _CategoryScreenStr.titleTab1, 'icon': Icons.trending_down},
  {'text': _CategoryScreenStr.titleTab2, 'icon': Icons.trending_up}
];

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  // Funcao para editar categoria
  void onEdit(Category category, BuildContext context) {
    Navigator.of(context).pushNamed(
      UpdateCategoryScreen.routeName,
      arguments: category,
    );
  }

  // Funcao para excluir categoria
  void onDelete(Category category, BuildContext context) {
    if (category.name == 'Outros') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(_CategoryScreenStr.errorNoPersmissionDelete),
        ),
      );

      return;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(_CategoryScreenStr.titleDelete),
            content: const Text(_CategoryScreenStr.contentDelete),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(_CategoryScreenStr.labelBtnCancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CategoryProviderController>(context,
                          listen: false)
                      .del(category);

                  Navigator.of(context).pop();
                },
                child: const Text(_CategoryScreenStr.labelBtnConfirm),
              ),
            ],
          );
        });
  }

  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _typeCategories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(_CategoryScreenStr.title),
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
        body: Consumer<CategoryProviderController>(
          builder: (context, value, child) {
            final spendingList = <Category>[];
            final incomeList = <Category>[];
            final categories = value.getAll();

            for (Category cate in categories) {
              if (cate.type == 'income') {
                incomeList.add(cate);
              } else {
                spendingList.add(cate);
              }
            }

            return TabBarView(children: [
              _Spedings(
                spendings: spendingList,
                onLongPress: onDelete,
                onTap: onEdit,
              ),
              _Incomes(
                incomes: incomeList,
                onLongPress: onDelete,
                onTap: onEdit,
              )
            ]);
          },
        ),
      ),
    );
  }
}

class _Incomes extends StatelessWidget {
  final List<Category> incomes;
  final void Function(Category category, BuildContext context) onTap;
  final void Function(Category category, BuildContext context) onLongPress;
  const _Incomes({
    Key? key,
    required this.incomes,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: incomes.map<Widget>((e) {
          return Material(
            child: InkWell(
              onTap: () {
                onTap(e, context);
              },
              onLongPress: () => onLongPress(e, context),
              child: CategoryWidget(
                category: e,
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            NewCategoryScreen.routeName,
            arguments: 'income',
          );
        },
        child: const Icon(Icons.trending_up),
      ),
    );
  }
}

class _Spedings extends StatelessWidget {
  final List<Category> spendings;
  final void Function(Category category, BuildContext context) onTap;
  final void Function(Category category, BuildContext context) onLongPress;
  const _Spedings({
    Key? key,
    required this.spendings,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: spendings.map<Widget>((e) {
          return Material(
            child: InkWell(
              onTap: () {
                onTap(e, context);
              },
              onLongPress: () => onLongPress(e, context),
              child: CategoryWidget(
                category: e,
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            NewCategoryScreen.routeName,
            arguments: 'speding',
          );
        },
        child: const Icon(Icons.trending_down),
      ),
    );
  }
}
