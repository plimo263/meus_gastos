import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/screen/category/new_category_screen.dart';
import 'package:meus_gastos/screen/category/update_category_screen.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/widgets/avatar_user_widget.dart';
import 'package:meus_gastos/widgets/background_delete_widget.dart';
import 'package:meus_gastos/widgets/category_widget.dart';
import 'package:meus_gastos/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

class _CategoryScreenStr {
  static const title = 'Categoria';
  static const titleTab1 = 'DESPESAS';
  static const titleTab2 = 'RECEITAS';
  static const errorNoPersmissionDelete =
      'Esta categoria não pode ser excluída';
  static const errorNoPersmissionEdit = 'Esta categoria não pode ser editada';
  static const titleDelete = 'Excluir Categoria';
  static const contentDelete =
      'Deseja realmente excluir esta categoria ?\n\nEla não poderá ser recuperada e todas as despesas/receitas vinculadas com ela seram transferidas para a categoria OUTROS.';
  static const labelBtnCancel = 'CANCELAR';
  static const labelBtnConfirm = 'CONFIRMAR';
  static const bodyBackCardDelete = 'EXCLUIR CATEGORIA';
}

const _typeCategories = [
  {'text': _CategoryScreenStr.titleTab1, 'icon': Icons.trending_down},
  {'text': _CategoryScreenStr.titleTab2, 'icon': Icons.trending_up}
];

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  // Funcao para editar categoria
  void onEdit(Category category, BuildContext context) {
    if (category.name == 'Outros') {
      AppSnackBar().snack(_CategoryScreenStr.errorNoPersmissionEdit);
      return;
    }
    Navigator.of(context).pushNamed(
      UpdateCategoryScreen.routeName,
      arguments: category,
    );
  }

  // Funcao para excluir categoria
  Future<bool?> onDelete(DismissDirection direction, Category category,
      BuildContext context) async {
    if (category.name == 'Outros') {
      AppSnackBar().snack(_CategoryScreenStr.errorNoPersmissionDelete);
      return false;
    }
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(_CategoryScreenStr.titleDelete),
            content: const Text(_CategoryScreenStr.contentDelete),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(_CategoryScreenStr.labelBtnCancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CategoryProviderController>(context,
                          listen: false)
                      .del(category);

                  Navigator.of(context).pop(true);
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
                onDelete: onDelete,
                onTap: onEdit,
              ),
              _Incomes(
                incomes: incomeList,
                onDelete: onDelete,
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
  final Future<bool?> Function(
          DismissDirection direction, Category category, BuildContext context)
      onDelete;
  const _Incomes({
    required this.incomes,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding:
            const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 72),
        children: incomes.map<Widget>((e) {
          return Dismissible(
            key: Key(e.id.toString()),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) => onDelete(direction, e, context),
            background: const BackgroundDeleteWidget(
                text: _CategoryScreenStr.bodyBackCardDelete),
            child: CategoryWidget(
              category: e,
              onTap: () => onTap(e, context),
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
  final Future<bool?> Function(
          DismissDirection direction, Category category, BuildContext context)
      onDelete;
  const _Spedings({
    required this.spendings,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding:
            const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 72),
        children: spendings.map<Widget>((e) {
          return Dismissible(
            key: Key(e.id.toString()),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) => onDelete(direction, e, context),
            background: const BackgroundDeleteWidget(
                text: _CategoryScreenStr.bodyBackCardDelete),
            child: CategoryWidget(
              category: e,
              onTap: () => onTap(e, context),
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

class _BackgroundDelete extends StatelessWidget {
  const _BackgroundDelete();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade800,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: 4),
            Text(
              _CategoryScreenStr.bodyBackCardDelete,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
