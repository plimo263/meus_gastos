/// Interface para definir tarefas basicas comuns que os repositorios devem ter
/// como insercao, atualizacao e exclusao de dados
abstract class BaseRepository<T> {
  /// Recupera todos os dados salvos
  Future<List<T>> getAll();

  ///Adiciona um novo item
  Future<T> add(T item);

  /// Edita um item Recebe e o substitui
  Future<T> update(T item);

  /// Exclui um item
  Future<void> del(T item);

  /// Exclui todos os items
  Future<void> delAll();
}
