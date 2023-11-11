import 'package:meus_gastos/dao/income_dao.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/repository/interfaces/base_repository.dart';
import 'package:meus_gastos/repository/interfaces/filter_repository.dart';

class IncomeRepository
    implements
        BaseRepository<FinancialIncome>,
        FilterRepository<FinancialIncome> {
  late final IncomeDAO incomeBox;

  IncomeRepository(this.incomeBox);

  @override
  Future<FinancialIncome> add(FinancialIncome item) async {
    return await incomeBox.add(item);
  }

  @override
  Future<void> del(FinancialIncome item) async {
    await incomeBox.del(item);
  }

  @override
  Future<void> delAll() async {
    await incomeBox.delAll();
  }

  @override
  Future<List<FinancialIncome>> getAll() async {
    return incomeBox.getAll();
  }

  @override
  Future<List<FinancialIncome>> getAllBetweenDates(
    DateTime de,
    DateTime ate,
  ) async {
    return await incomeBox.getFinancialIncomeByDate(
      de,
      ate,
    );
  }

  @override
  Future<FinancialIncome> getById(int id) async {
    return await incomeBox.getById(id);
  }

  @override
  Future<FinancialIncome> update(FinancialIncome item) async {
    return await incomeBox.update(item);
  }
}
