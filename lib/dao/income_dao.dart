import '../widgets/income.dart';

/// Abstração para manutenção das entradas de recurso
/// em um sistema de armazenamento
abstract class IncomeDAO {
  /// Recupera a lista de entradas informando a data do filtro
  Future<List<Income>> getIncomeByDate(DateTime de, DateTime ate);

  /// Recupera uma entrada por id
  Future<Income> getIncomeById(int id);

  /// Cria uma nova entrada de recurso
  Future<Income> addIncome(Income income);

  /// Atualiza a entrada enviada no db
  Future<Income> updateIncome(Income income);

  // Exclui a entrada enviada do db
  Future<void> deleteIcome(Income income);
}
