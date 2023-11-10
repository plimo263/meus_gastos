import 'package:meus_gastos/dao/base_dao.dart';
import 'package:meus_gastos/model/financial_income.dart';

/// Abstração para manutenção das entradas de recurso
/// em um sistema de armazenamento
abstract class IncomeDAO extends BaseDao<FinancialIncome> {
  /// Recupera a lista de entradas informando a data do filtro
  Future<List<FinancialIncome>> getFinancialIncomeByDate(
    DateTime de,
    DateTime ate,
  );
}
