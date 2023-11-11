/// Inteface para implementação de filtros a serem aplicados aos repositorios
abstract class FilterRepository<T> {
  /// Recupera um unico item
  Future<T> getById(int id);

  /// Recupera itens por data
  Future<List<T>> getAllBetweenDates(DateTime de, DateTime ate);
}
