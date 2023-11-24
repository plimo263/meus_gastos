import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/model/user.dart';

/// Interface para manipulação das categorias
abstract class CreditCardController {
  /// Rotina de inicializacao no controller
  Future<void> init(User user);

  /// Recupera a lista de cartoes de creditos ativos no controller
  List<CreditCard> getAll();

  /// Atualiza o cartão de credito
  Future<void> update(CreditCard creditCard);

  /// Adiciona um novo cartão de crédito
  Future<void> add(CreditCard creditCard);

  /// Exclui cartão de credito
  void del(CreditCard creditCard);

  /// Exclui todos os cartões de crédito pode ser no banco ou nao
  void delAll({clearDB = false});
}
