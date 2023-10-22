import 'package:meus_gastos/constants/database.dart';
import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Implementação concreta de implementação de categorias
class CategoryDAOImpl implements CategoryDAO {
  static const idColumn = 'id';
  static const nameColumn = 'nome';
  static const iconColumn = 'icone';
  static const tableName = 'categoria';

  late Database db;

  @override
  Future<Category> addCategory(Category category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(Category category) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getAllCategorys() {
    // TODO: implement getAllCategorys
    throw UnimplementedError();
  }

  @override
  Future<Category?> getCategoryById(int id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<Category> updateCategory(Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    final path = join(await getDatabasesPath(), databaseName);
    db = await openDatabase(path);
  }
}
