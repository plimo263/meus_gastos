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
  Future<FinancialIncome> add(FinancialIncome item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> del(FinancialIncome item) {
    // TODO: implement del
    throw UnimplementedError();
  }

  @override
  Future<void> delAll() async {
    await box.removeAllAsync();
  }

  @override
  Future<List<FinancialIncome>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<FinancialIncome> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<FinancialIncome>> getFinancialIncomeByDate(
      DateTime de, DateTime ate) {
    // TODO: implement getFinancialIncomeByDate
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<FinancialIncome> update(FinancialIncome item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
