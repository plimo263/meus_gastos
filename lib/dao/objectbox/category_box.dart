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
  Future<Category> add(Category item) async {
    int indice = await box.putAsync(item);
    item.id = indice;
    return item;
  }

  @override
  Future<void> del(Category item) async {
    await box.removeAsync(item.id);
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<Category>> getAll() async {
    return await box.getAllAsync();
  }

  @override
  Future<Category> getById(int id) async {
    final category = await box.getAsync(id);
    if (category == null) {
      throw Exception('A categoria do id $id não existe');
    }
    return category;
  }

  @override
  Future<void> init() async {}

  @override
  Future<Category> update(Category item) async {
    await box.putAsync(item);
    return item;
  }
}
