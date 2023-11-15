import 'package:meus_gastos/dao/credit_card_dao.dart';
import 'package:meus_gastos/model/credit_card.dart';

import '../../databases/object_db/objectbox.g.dart';

/// Interage com o banco de dados para ações sobre os cartões de credito
class CreditCardBoxImpl implements CreditCardDao {
  late final Store store;
  late final Box<CreditCard> box;

  CreditCardBoxImpl(this.store) {
    box = store.box<CreditCard>();
  }

  @override
  Future<CreditCard> add(CreditCard item) async {
    int indice = await box.putAsync(item);
    item.id = indice;
    return item;
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
}
