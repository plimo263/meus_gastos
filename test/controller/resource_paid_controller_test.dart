import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/controller/resource_paid_controller.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/income_box.dart';
import 'package:meus_gastos/dao/objectbox/speding_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/resource_paid.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/repository/income_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';

final dateRegister = DateTime(2023, 11, 11);

final category = Category(name: 'Salario', icon: 984246);
final category2 = Category(name: 'Padaria', icon: 984246);

final financialIncome = FinancialIncome(
  category: category,
  name: 'Salário de outubro',
  value: 1500.0,
  dateRegister: dateRegister,
);
final spedingMoney = SpedingMoney(
  category: category2,
  name: 'Anuidade',
  value: 50.0,
  dateRegister: dateRegister,
);

void main() {
  late ResourcePaidController resourcePaidController;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    resourcePaidController = ResourcePaidProviderController(
      IncomeRepository(
        connector.income as IncomeBoxImpl,
      ),
      SpedingRepository(connector.speding as SpedingBoxImpl),
      <ResourcePaid>[financialIncome, spedingMoney],
    );
    // Limpando a casa
    resourcePaidController.delAll(clearDB: true);
  });

  tearDownAll(() {
    resourcePaidController.delAll(clearDB: true);
  });

  group('ResourcePaidControllerProvider', () {
    test('add', () async {
      final financialIncome = FinancialIncome(
        category: category,
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
      resourcePaidController.delAll();
    });
  });
}
