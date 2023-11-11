import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/income_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/repository/income_repository.dart';

final dateRegisterAdd = DateTime(2023, 11, 11);

final financialIncome = FinancialIncome(
  category: Category(name: 'Alimentação', icon: 898878),
  name: 'Padaria',
  value: 50.0,
  dateRegister: dateRegisterAdd,
);

void main() {
  late final IncomeRepository incomeRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    incomeRepository = IncomeRepository(connector.income as IncomeBoxImpl);
    // Limpando a casa
    incomeRepository.delAll();
  });

  tearDownAll(() {
    incomeRepository.delAll();
  });

  group('IncomeRepository', () {
    test('add', () async {
      final income = await incomeRepository.add(financialIncome);
      expect(income, isA<FinancialIncome>());
    });

    test('getAll', () async {
      final incomeList = await incomeRepository.getAll();
      expect(incomeList.isNotEmpty, isTrue);
    });

    test('update', () async {
      financialIncome.name = 'Padaria';
      final income = await incomeRepository.update(financialIncome);

      expect(income.name, 'Padaria');
    });

    test('getAllBetweenDates', () async {
      List<FinancialIncome> incomeList =
          await incomeRepository.getAllBetweenDates(
        dateRegisterAdd,
        dateRegisterAdd,
      );
      expect(incomeList.isNotEmpty, isTrue);
    });

    test('delAll', () async {
      await incomeRepository.delAll();
      final incomeList = await incomeRepository.getAll();
      expect(incomeList.isEmpty, isTrue);
    });
  });
}
