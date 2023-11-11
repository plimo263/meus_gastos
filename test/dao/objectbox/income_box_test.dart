import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/income_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';

final financialIncome = FinancialIncome(
    category: Category(name: 'Alimentação', icon: 898878),
    name: 'Padaria',
    value: 50.0,
    dateRegister: DateTime.now());

void main() {
  late final IncomeBoxImpl incomeBox;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    incomeBox = connector.income as IncomeBoxImpl;
    // Limpando a casa
    await incomeBox.delAll();
  });

  tearDownAll(() async {
    await incomeBox.delAll();
  });

  group('IncomeBoxDao', () {
    test('add', () async {
      final box = incomeBox;
      final cate = await box.add(financialIncome);
      expect(cate, isA<FinancialIncome>());
    });

    test('getAll', () async {
      final box = incomeBox;
      final financialIncomeList = await box.getAll();
      expect(financialIncomeList, isA<List<FinancialIncome>>());
    });

    test('getById', () async {
      final box = incomeBox;
      await box.add(financialIncome);
      final financialIncomeList = await box.getById(1);
      expect(financialIncomeList, isA<FinancialIncome>());
    });

    test('update', () async {
      final box = incomeBox;
      FinancialIncome income = await box.add(financialIncome);
      income.name = 'Alimento';
      income = await box.update(income);

      expect(income, isA<FinancialIncome>());
      expect(income.name, 'Alimento');
    });

    test('del', () async {
      final box = incomeBox;
      FinancialIncome income = await box.add(financialIncome);

      await box.del(income);

      List<FinancialIncome> incomeList = await box.getAll();
      expect(incomeList.isEmpty, isTrue);
    });

    test('delAll', () async {
      final box = incomeBox;
      await box.add(financialIncome);

      await box.delAll();

      List<FinancialIncome> incomeList = await box.getAll();
      expect(incomeList.isEmpty, isTrue);
    });
  });
}
