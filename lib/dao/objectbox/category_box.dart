import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/user.dart';

class CategoryBoxImpl implements CategoryDAO {
  late final Store store;
  late final Box<Category> box;

  CategoryBoxImpl(this.store) {
    box = store.box<Category>();
  }

  Future<List<Category>> _getByName(String name) async {
    final query = box.query(Category_.name.equals(name)).build();
    return await query.findAsync();
  }

  @override
  Future<Category> add(Category item) async {
    // Verifica se a categoria existe
    final categoriesCreated = await _getByName(item.name);
    // Nao existe, pode criar a nova
    if (categoriesCreated.isEmpty) {
      int indice = await box.putAsync(item);
      item.id = indice;
      return item;
    }
    // Existe, agora precisa saber se e do usuario logado
    final categoryList = categoriesCreated
        .where((ele) =>
            ele.user.target!.id == item.user.target!.id &&
            ele.name == item.name)
        .toList();

    /// Nao existe do usuario enviado, criar
    if (categoryList.isEmpty) {
      int indice = await box.putAsync(item);
      item.id = indice;
      return item;
    }
    // Lancar uma exception pois ja existe esta categoria
    throw UniqueViolationException('A categoria ${item.name} já existe');
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

  @override
  Future<List<Category>> getAllByUser(User user) async {
    final query = box.query(Category_.user.equals(user.id)).build();
    return await query.findAsync();
  }
}
