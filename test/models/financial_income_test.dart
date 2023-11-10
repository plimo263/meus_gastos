import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';

void main() {
  group('FinancialIncome', () {
    test('constructor', () {
      final category = Category(name: 'Pagamento', icon: 889899);

      final financialIncome = FinancialIncome(
        category: category,
        name: 'Salário de outubro',
        value: 1500.0,
        dateRegister: DateTime.now(),
      );

      expect(financialIncome, isA<FinancialIncome>());
    });

    test('getDateRegister()', () {
      final category = Category(name: 'Pagamento', icon: 889899);

      final financialIncome = FinancialIncome(
        category: category,
        name: 'Salário de outubro',
        value: 1500.0,
        dateRegister: DateTime(2023, 11, 10),
      );

      expect(financialIncome.getDateRegister(), '10/11/23');
    });

    test('getValueMonetary()', () {
      final category = Category(name: 'Pagamento', icon: 889899);

      final financialIncome = FinancialIncome(
        category: category,
        name: 'Salário de outubro',
        value: 1500.0,
        dateRegister: DateTime(2023, 11, 10),
      );

      expect(financialIncome.getValueMonetary(), 'R\$ 1.500,00');
    });
  });
}
