/// Abstração para implementação do CRUD basico de qualquer registro de
/// dados.
abstract class BaseDao<T> {
  /// Inicializador ao conector de recurso do db
  Future<void> init();

  /// Recupera todos os itens
  Future<List<T>> getAll();

  /// Recupera por id
  Future<T> getById(int id);

  /// Adiciona um novo item
  Future<T> add(T item);

  /// Atualiza um item existente
  Future<T> update(T item);

  /// Exclui um item existente
  Future<void> del(T item);

  /// Exclui todos os items
  Future<void> delAll();
}
