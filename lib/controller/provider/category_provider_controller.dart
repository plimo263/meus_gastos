import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/category_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';

class CategoryProviderController extends ChangeNotifier
    implements CategoryController {
  final List<Category> _categories;
  final CategoryRepository categoryRepository;
  CategoryProviderController(
    this.categoryRepository,
    this._categories,
  );

  @override
  Future<void> add(Category category) async {
    //
    final cate = await categoryRepository.add(category);
    _categories.add(cate);
    notifyListeners();
  }

  @override
  void del(Category category) {
    _categories.remove(category);
    //
    categoryRepository.del(category);
    notifyListeners();
  }

  @override
  void delAll({clearDB = false}) {
    _categories.clear();
    if (clearDB) {
      categoryRepository.delAll();
    }
    notifyListeners();
  }

  @override
  List<Category> getAll() {
    return _categories;
  }

  @override
  Future<void> update(Category category) async {
    final List<Category> categoryList = _categories.map((ele) {
      if (ele == category) {
        return category;
      }
      return ele;
    }).toList();

    _categories.clear();
    _categories.addAll(categoryList);
    //
    categoryRepository.update(category);
    notifyListeners();
  }

  @override
  Future<void> init(User user) async {
    List<Category> categoryList = await categoryRepository.getAllByUser(user);
    _categories.clear();
    _categories.addAll(categoryList);
    notifyListeners();
  }
}
