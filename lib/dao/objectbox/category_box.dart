import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';
import 'package:meus_gastos/model/category.dart';

class CategoryBoxImpl implements CategoryDAO {
  late final Store store;
  late final Box<Category> box;

  CategoryBoxImpl(this.store) {
    box = store.box<Category>();
  }

  @override
  Future<Category> add(Category item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> del(Category item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<Category>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Category> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<Category> update(Category item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
