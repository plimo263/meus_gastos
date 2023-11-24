import 'package:meus_gastos/dao/credit_card_dao.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/model/user.dart';

import '../../databases/object_db/objectbox.g.dart';

/// Interage com o banco de dados para ações sobre os cartões de credito
class CreditCardBoxImpl implements CreditCardDao {
  late final Store store;
  late final Box<CreditCard> box;

  CreditCardBoxImpl(this.store) {
    box = store.box<CreditCard>();
  }

  Future<List<CreditCard>> _getByName(String name) async {
    final query = box.query(CreditCard_.name.equals(name)).build();
    return await query.findAsync();
  }

  @override
  Future<CreditCard> add(CreditCard item) async {
    // Verifica se o cartão de crédito ja existe
    final creditCardCreated = await _getByName(item.name);
    // Nao existe, pode criar a nova
    if (creditCardCreated.isEmpty) {
      int indice = await box.putAsync(item);
      item.id = indice;
      return item;
    }
    // Existe, agora precisa saber se e do usuario logado
    final creditCardList = creditCardCreated
        .where((ele) =>
            ele.user.target!.id == item.user.target!.id &&
            ele.name == item.name)
        .toList();

    /// Nao existe do usuario enviado, criar
    if (creditCardList.isEmpty) {
      int indice = await box.putAsync(item);
      item.id = indice;
      return item;
    }
    // Lancar uma exception pois ja existe esta categoria
    throw UniqueViolationException(
      'O cartão de crédito ${item.name} já existe',
    );
  }

  @override
  Future<void> del(CreditCard item) async {
    await box.removeAsync(item.id);
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<CreditCard>> getAll() async {
    return await box.getAllAsync();
  }

  @override
  Future<CreditCard> getById(int id) async {
    final creditCard = await box.getAsync(id);
    if (creditCard == null) {
      throw Exception('A cartão de crédito de id $id não existe');
    }
    return creditCard;
  }

  @override
  Future<void> init() async {}

  @override
  Future<CreditCard> update(CreditCard item) async {
    await box.putAsync(item);
    return item;
  }

  @override
  Future<List<CreditCard>> getAllByUser(User user) async {
    final query = box.query(CreditCard_.user.equals(user.id)).build();
    return await query.findAsync();
  }
}
