import 'package:meus_gastos/dao/base_dao.dart';
import 'package:meus_gastos/model/speding_money.dart';

/// Interface para implementação e metodos para lidar com valores de saida
/// da aplicação.
abstract class SpedingDAO extends BaseDao<SpedingMoney> {
  /// Recupera a lista de saidas realizando um filtro de periodo de/ate
  Future<List<SpedingMoney>> getSpedingMoneyByDate(
    DateTime de,
    DateTime ate,
  );
}
