import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/model/category.dart';
import 'interfaces/base_repository.dart';

class CategoryRepository implements BaseRepository<Category> {
  late final CategoryDAO categoryBox;

  CategoryRepository(this.categoryBox);

  @override
  Future<Category> add(Category item) async {
    return await categoryBox.add(item);
  }

  @override
  Future<void> del(Category item) async {
    await categoryBox.del(item);
  }

  @override
  Future<void> delAll() async {
    await categoryBox.delAll();
  }

  @override
  Future<List<Category>> getAll() async {
    return await categoryBox.getAll();
  }

  @override
  Future<Category> update(Category item) async {
    return await categoryBox.update(item);
  }
}
