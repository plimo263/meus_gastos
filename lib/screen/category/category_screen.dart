import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/screen/category/new_category_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Category> _spedingList = [];
  final List<Category> _incomeList = [];
  Category? _categorySelect;

  @override
  void initState() {
    super.initState();

    Future.microtask(onRefresh);
  }

  void onRefresh() {
    //
    _incomeList.clear();
    _spedingList.clear();

    final categories =
        (Provider.of<CategoryProviderController>(context, listen: false)
            .getAll());
    for (Category cate in categories) {
      if (cate.type == 'income') {
        _incomeList.add(cate);
      } else {
        _spedingList.add(cate);
      }
    }
    setState(() {});
  }

  //
  void onCategorySelected(Category category) {
    setState(() {
      _categorySelect = category;
    });
  }

  // Funcao para editar categoria
  void onEdit() {}

  // Funcao para excluir categoria
  void onDelete() {
    if (_categorySelect != null && _categorySelect!.name == 'Outros') {
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
                  setState(() {
                    _categorySelect = null;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(_CategoryScreenStr.labelBtnCancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CategoryProviderController>(context,
                          listen: false)
                      .del(_categorySelect!);
                  setState(() {
                    _categorySelect = null;
                  });
                  onRefresh();
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
          actions: _categorySelect != null
              ? [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _categorySelect = null;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ).animate().scale(
                        begin: const Offset(.1, .1),
                        end: const Offset(1, 1),
                        duration: 100.ms,
                      ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete),
                  ).animate().scale(
                        begin: const Offset(.1, .1),
                        end: const Offset(1, 1),
                        duration: 120.ms,
                      ),
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                  ).animate().scale(
                        begin: const Offset(.1, .1),
                        end: const Offset(1, 1),
                        duration: 140.ms,
                      ),
                ]
              : [
                  const AvatarUserWidget().animate().scale(
                        begin: const Offset(.1, .1),
                        end: const Offset(1, 1),
                        duration: 100.ms,
                      ),
                  const PopupMenuWidget().animate().scale(
                        begin: const Offset(.1, .1),
                        end: const Offset(1, 1),
                        duration: 100.ms,
                      ),
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
            onRefresh: onRefresh,
            onLongPress: onCategorySelected,
          ),
          _Incomes(
            incomes: _incomeList,
            onRefresh: onRefresh,
            onLongPress: onCategorySelected,
          )
        ]),
      ),
    );
  }
}

class _Incomes extends StatelessWidget {
  final List<Category> incomes;
  final VoidCallback onRefresh;
  final void Function(Category category) onLongPress;
  const _Incomes({
    Key? key,
    required this.incomes,
    required this.onRefresh,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: incomes.map<Widget>((e) {
          return Material(
            child: InkWell(
              onLongPress: () => onLongPress(e),
              child: CategoryWidget(
                category: e,
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(
            NewCategoryScreen.routeName,
            arguments: 'income',
          )
              .then((value) {
            if (value != null && value is Category) {
              onRefresh();
            }
          });
        },
        child: const Icon(Icons.trending_up),
      ),
    );
  }
}

class _Spedings extends StatelessWidget {
  final List<Category> spendings;
  final VoidCallback onRefresh;
  final void Function(Category category) onLongPress;
  const _Spedings({
    Key? key,
    required this.spendings,
    required this.onRefresh,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: spendings.map<Widget>((e) {
          return Material(
            child: InkWell(
              onLongPress: () => onLongPress(e),
              child: CategoryWidget(
                category: e,
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(
            NewCategoryScreen.routeName,
            arguments: 'speding',
          )
              .then((value) {
            if (value != null && value is Category) {
              onRefresh();
            }
          });
        },
        child: const Icon(Icons.trending_down),
      ),
    );
  }
}
