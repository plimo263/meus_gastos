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
  Future<SpedingMoney> add(SpedingMoney item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> del(SpedingMoney item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<SpedingMoney>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<SpedingMoney> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<SpedingMoney>> getSpedingMoneyByDate(DateTime de, DateTime ate) {
    // TODO: implement getSpedingMoneyByDate
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<SpedingMoney> update(SpedingMoney item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
