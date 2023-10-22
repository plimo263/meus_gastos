import '../widgets/speding.dart';

abstract class SpedingDAO {
  /// Recupera a lista de saidas realizando um filtro de periodo de/ate
  Future<List<Speding>> getSpedingByDate(DateTime de, DateTime ate);

  /// Recupera a saída por id
  Future<Speding> getSpedingById(int id);

  /// Cria uma nova saida de recurso financeiro
  Future<Speding> addSpeding(Speding speding);

  /// Atualiza o saida no db com os dados do recurso enviado
  Future<Speding> updateSpeding(Speding speding);

  // Exclui a saida do recurso do db
  Future<void> deleteSpeding(Speding speding);
}
