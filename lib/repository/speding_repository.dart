import 'package:meus_gastos/dao/speding_dao.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/repository/interfaces/base_repository.dart';
import 'package:meus_gastos/repository/interfaces/filter_repository.dart';

class SpedingRepository
    implements BaseRepository<SpedingMoney>, FilterRepository<SpedingMoney> {
  late final SpedingDAO spedingBox;

  SpedingRepository(this.spedingBox);

  @override
  Future<SpedingMoney> add(SpedingMoney item) async {
    return await spedingBox.add(item);
  }

  @override
  Future<void> del(SpedingMoney item) async {
    await spedingBox.del(item);
  }

  @override
  Future<void> delAll() async {
    await spedingBox.delAll();
  }

  @override
  Future<List<SpedingMoney>> getAll() async {
    return spedingBox.getAll();
  }

  @override
  Future<List<SpedingMoney>> getAllBetweenDates(
    DateTime de,
    DateTime ate,
  ) async {
    return await spedingBox.getSpedingMoneyByDate(
      de,
      ate,
    );
  }

  @override
  Future<SpedingMoney> getById(int id) async {
    return await spedingBox.getById(id);
  }

  @override
  Future<SpedingMoney> update(SpedingMoney item) async {
    return await spedingBox.update(item);
  }

  @override
  Future<List<SpedingMoney>> getAllByUser(User user) async {
    return await spedingBox.getAllByUser(user);
  }
}
