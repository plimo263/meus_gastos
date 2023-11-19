import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/controller/category_controller.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/controller/resource_paid_controller.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/dao/objectbox/income_box.dart';
import 'package:meus_gastos/dao/objectbox/speding_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/interfaces/resource_paid.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/repository/income_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';

final dateRegister = DateTime(2023, 11, 11);

Category category = Category(name: 'Salario', icon: 984246, type: 'income');
Category category2 = Category(name: 'Padaria', icon: 984246, type: 'speding');

FinancialIncome financialIncome = FinancialIncome(
  name: 'Salário de outubro',
  value: 1500.0,
  dateRegister: dateRegister,
);
SpedingMoney spedingMoney = SpedingMoney(
  name: 'Anuidade',
  value: 50.0,
  dateRegister: dateRegister,
);

void main() {
  late ResourcePaidController resourcePaidController;
  late CategoryController categoryController;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    resourcePaidController = ResourcePaidProviderController(
      IncomeRepository(
        connector.income as IncomeBoxImpl,
      ),
      SpedingRepository(connector.speding as SpedingBoxImpl),
      <ResourcePaid>[financialIncome, spedingMoney],
    );
    categoryController = CategoryProviderController(
        CategoryRepository(
          connector.category as CategoryBoxImpl,
        ),
        []);
    // Limpando a casa
    categoryController.delAll(clearDB: true);
    resourcePaidController.delAll(clearDB: true);

    await categoryController.add(category);
    await categoryController.add(category2);

    category = categoryController
        .getAll()
        .firstWhere((element) => element.name == category.name);

    category2 = categoryController
        .getAll()
        .firstWhere((element) => element.name == category2.name);

    financialIncome.category.target = category;
    spedingMoney.category.target = category2;
  });

  tearDownAll(() {
    categoryController.delAll(clearDB: true);
    resourcePaidController.delAll(clearDB: true);
  });

  group('ResourcePaidControllerProvider', () {
    test('add', () async {
      final financialIncome = FinancialIncome(
        name: 'Trabalho',
        value: 1500.0,
        dateRegister: dateRegister,
      );
      await resourcePaidController.add(financialIncome);
    });

    test('update', () async {
      final listResource = resourcePaidController.getAll();
      final item = listResource[0];
      await resourcePaidController.update(item);
    });

    test('getAll', () {
      final listResource = resourcePaidController.getAll();
      expect(listResource, isNotEmpty);
    });

    test('applyFilterDate', () async {
      await resourcePaidController.applyFilterDate(dateRegister, dateRegister);
      final listResource = resourcePaidController.getAll();
      expect(listResource, isNotEmpty);
    });

    test('del', () {
      resourcePaidController.del(financialIncome);
    });

    test('delAll', () {
      resourcePaidController.delAll(clearDB: true);
    });
  });
}
