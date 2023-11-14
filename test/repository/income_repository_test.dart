import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/dao/objectbox/income_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/repository/income_repository.dart';

final dateRegisterAdd = DateTime(2023, 11, 11);

Category category = Category(
  name: 'Alimentação',
  icon: 898878,
);
FinancialIncome financialIncome = FinancialIncome(
  name: 'Padaria',
  value: 50.0,
  dateRegister: dateRegisterAdd,
);

void main() {
  late final IncomeRepository incomeRepository;
  late final CategoryRepository categoryRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    incomeRepository = IncomeRepository(connector.income as IncomeBoxImpl);
    categoryRepository = CategoryRepository(
      connector.category as CategoryBoxImpl,
    );
    // Limpando a casa
    await categoryRepository.delAll();
    await incomeRepository.delAll();

    category = await categoryRepository.add(category);

    financialIncome.category.target = category;
  });

  tearDownAll(() async {
    // Limpando a casa
    await categoryRepository.delAll();
    await incomeRepository.delAll();
  });

  group('IncomeRepository', () {
    test('add', () async {
      financialIncome = await incomeRepository.add(financialIncome);
      expect(financialIncome, isA<FinancialIncome>());
    });

    test('getAll', () async {
      final incomeList = await incomeRepository.getAll();
      expect(incomeList.isNotEmpty, isTrue);
    });

    test('update', () async {
      financialIncome.name = 'Padaria Nova';
      financialIncome = await incomeRepository.update(financialIncome);

      expect(financialIncome.name, 'Padaria Nova');
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
