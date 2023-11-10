import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';

final financialIncome = FinancialIncome(
    category: Category(name: 'Alimentação', icon: 898878),
    name: 'Padaria',
    value: 50.0,
    dateRegister: DateTime.now());

void main() {
  group('IncomeBoxDao', () {
    final store = null;

    final box = IncomeBoxDao(store);

    test('add', () async {
      final cate = await box.add(financialIncome);
      expect(cate, isA<FinancialIncome>());
    });

    test('getAll', () async {
      final financialIncomeList = await box.getAll();
      expect(financialIncomeList, isA<List<FinancialIncome>>());
    });

    test('getById', () async {
      final cate = await box.add(financialIncome);
      final financialIncomeList = await box.getById(1);
      expect(financialIncomeList, isA<FinancialIncome>());
    });

    test('update', () async {
      FinancialIncome cate = await box.add(financialIncome);
      cate.name = 'Alimento';
      cate = await box.update(cate);

      expect(cate, isA<FinancialIncome>());
      expect(cate.name, 'Alimento');
    });

    test('del', () async {
      FinancialIncome cate = await box.add(financialIncome);

      await box.del(cate);

      List<FinancialIncome> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });

    test('delAll', () async {
      FinancialIncome cate = await box.add(financialIncome);

      await box.delAll(cate);

      List<FinancialIncome> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });
  });
}
