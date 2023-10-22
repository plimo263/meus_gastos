import '../model/category.dart';

/// Abstração para manutenção de categorias
abstract class CategoryDAO {
  /// Inicializador ao conector de recurso do db
  Future<void> init();

  /// Recupera todas as categorias cadastradas
  Future<List<Category>> getAllCategorys();

  /// Recupera uma categoria por ID
  Future<Category?> getCategoryById(int id);

  /// Cria uma nova categoria
  Future<Category> addCategory(Category category);

  /// Atualiza a categoria
  Future<Category> updateCategory(Category category);

  // Exclui a categoria
  Future<void> deleteCategory(Category category);
}
