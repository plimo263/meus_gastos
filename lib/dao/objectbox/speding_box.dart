import 'package:meus_gastos/dao/speding_dao.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';
import 'package:meus_gastos/model/speding_money.dart';

class SpedingBoxImpl implements SpedingDAO {
  late final Box<SpedingMoney> box;
  late final Store store;

  SpedingBoxImpl(this.store) {
    box = store.box<SpedingMoney>();
  }
  @override
  Future<SpedingMoney> add(SpedingMoney item) async {
    int index = await box.putAsync(item);
    item.id = index;
    return item;
  }

  @override
  Future<void> del(SpedingMoney item) async {
    await box.removeAsync(item.id);
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<SpedingMoney>> getAll() async {
    return await box.getAllAsync();
  }

  @override
  Future<SpedingMoney> getById(int id) async {
    final speding = await box.getAsync(id);
    if (speding == null) {
      throw Exception('A saída financeira com id $id não encontrado');
    }
    return speding;
  }

  @override
  Future<List<SpedingMoney>> getSpedingMoneyByDate(
    DateTime de,
    DateTime ate,
  ) async {
    final query = box
        .query(
          SpedingMoney_.dateRegister.between(
            de.millisecondsSinceEpoch,
            ate.millisecondsSinceEpoch,
          ),
        )
        .build();
    return await query.findAsync();
  }

  @override
  Future<void> init() async {}

  @override
  Future<SpedingMoney> update(SpedingMoney item) async {
    await box.putAsync(item);
    return item;
  }
}
