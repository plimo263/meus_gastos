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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  // Funcao para editar categoria
  void onEdit(Category category, BuildContext context) {
    final refStr = AppLocalizations.of(context);
    if (category.name == 'Outros') {
      AppSnackBar().snack(refStr!.categoryErrorNoPersmissionEdit);
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
    final refStr = AppLocalizations.of(context);
    if (category.name == 'Outros') {
      AppSnackBar().snack(refStr!.categoryErrorNoPersmissionDelete);
      return false;
    }
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(refStr!.categoryTitleDelete),
            content: Text(refStr.categoryContentDelete),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(refStr.categoryLabelBtnCancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CategoryProviderController>(context,
                          listen: false)
                      .del(category);

                  Navigator.of(context).pop(true);
                },
                child: Text(refStr.categoryLabelBtnConfirm),
              ),
            ],
          );
        });
  }

  List<Map<String, dynamic>> getTypeCategories(BuildContext context) {
    final refStr = AppLocalizations.of(context);
    return [
      {'text': refStr!.categoryTitleTab1, 'icon': Icons.trending_down},
      {'text': refStr.categoryTitleTab2, 'icon': Icons.trending_up}
    ];
  }

  //
  @override
  Widget build(BuildContext context) {
    final typeCategories = getTypeCategories(context);
    final refStr = AppLocalizations.of(context);

    return DefaultTabController(
      length: typeCategories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(refStr!.categoryTitle),
          actions: const [
            AvatarUserWidget(),
            PopupMenuWidget(),
          ],
          bottom: TabBar(
              tabs: typeCategories
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
    final refStr = AppLocalizations.of(context);
    return Scaffold(
      body: ListView(
        padding:
            const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 72),
        children: incomes.map<Widget>((e) {
          return Dismissible(
            key: Key(e.id.toString()),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) => onDelete(direction, e, context),
            background: BackgroundDeleteWidget(
              text: refStr!.categoryBodyBackCardDelete,
            ),
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
    final refStr = AppLocalizations.of(context);
    return Scaffold(
      body: ListView(
        padding:
            const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 72),
        children: spendings.map<Widget>((e) {
          return Dismissible(
            key: Key(e.id.toString()),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction) => onDelete(direction, e, context),
            background: BackgroundDeleteWidget(
              text: refStr!.categoryBodyBackCardDelete,
            ),
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
