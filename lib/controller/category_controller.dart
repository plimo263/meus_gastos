import 'package:meus_gastos/model/category.dart';

/// Interface para manipulação das categorias
abstract class CategoryController {
  /// Recupera a lista de categorias ativas no controller
  List<Category> getAll();

  /// Atualiza a categoria
  Future<void> update(Category category);

  /// Adiciona uma nova categoria
  Future<void> add(Category category);

  /// Exclui uma categoria
  void del(Category category);

  /// Exclui todas as categorias pode ser no banco ou nao
  void delAll({clearDB = false});
}
