import 'package:meus_gastos/dao/income_dao.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';
import 'package:meus_gastos/model/financial_income.dart';

class IncomeBoxImpl implements IncomeDAO {
  late final Box<FinancialIncome> box;
  late final Store store;

  IncomeBoxImpl(this.store) {
    box = store.box<FinancialIncome>();
  }

  @override
  Future<FinancialIncome> add(FinancialIncome item) async {
    int index = await box.putAsync(item);
    item.id = index;
    return item;
  }

  @override
  Future<void> del(FinancialIncome item) async {
    await box.removeAsync(item.id);
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<FinancialIncome>> getAll() async {
    return await box.getAllAsync();
  }

  @override
  Future<FinancialIncome> getById(int id) async {
    final income = await box.getAsync(id);
    if (income == null) {
      throw Exception('Recurso financeiro com id $id não encontrado');
    }
    return income;
  }

  @override
  Future<List<FinancialIncome>> getFinancialIncomeByDate(
    DateTime de,
    DateTime ate,
  ) async {
    final query = box
        .query(
          FinancialIncome_.dateRegister.between(
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
  Future<FinancialIncome> update(FinancialIncome item) async {
    await box.putAsync(item);
    return item;
  }
}
