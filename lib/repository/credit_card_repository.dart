import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/dao/credit_card_dao.dart';

import '../model/credit_card.dart';
import 'interfaces/base_repository.dart';

class CreditCardRepository implements BaseRepository<CreditCard> {
  late final CreditCardDao creditCardBox;

  CreditCardRepository(this.creditCardBox);

  @override
  Future<CreditCard> add(CreditCard item) async {
    return await creditCardBox.add(item);
  }

  @override
  Future<void> del(CreditCard item) async {
    await creditCardBox.del(item);
  }

  @override
  Future<void> delAll() async {
    await creditCardBox.delAll();
  }

  @override
  Future<List<CreditCard>> getAll() async {
    return await creditCardBox.getAll();
  }

  @override
  Future<CreditCard> update(CreditCard item) async {
    return await creditCardBox.update(item);
  }
}
