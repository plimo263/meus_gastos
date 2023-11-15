import 'package:meus_gastos/dao/base_dao.dart';
import 'package:meus_gastos/model/credit_card.dart';

/// Abstração para manutenção de categorias
/// Categorias são a forma de separar os recursos de entrada/saida do aplicativo
abstract class CreditCardDao extends BaseDao<CreditCard> {}
