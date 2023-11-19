import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/speding_money.dart';

void main() {
  group('SpedingMoney', () {
    test('constructor', () {
      final category = Category(name: 'Cartão', icon: 889899, type: 'income');

      final spedingMoney = SpedingMoney(
        name: 'Anuidade',
        value: 50.0,
        dateRegister: DateTime.now(),
      );
      spedingMoney.category.target = category;

      expect(spedingMoney, isA<SpedingMoney>());
    });

    test('getDateRegister()', () {
      final category = Category(name: 'Cartão', icon: 889899, type: 'income');

      final spedingMoney = SpedingMoney(
        name: 'Anuidade',
        value: 50.0,
        dateRegister: DateTime(2023, 11, 10),
      );
      spedingMoney.category.target = category;

      expect(spedingMoney.getDateRegister(), '10/11/23');
    });

    test('getValueMonetary()', () {
      final category = Category(name: 'Cartão', icon: 889899, type: 'income');

      final spedingMoney = SpedingMoney(
        name: 'Anuidade',
        value: 50.0,
        dateRegister: DateTime(2023, 11, 10),
      );
      spedingMoney.category.target = category;

      expect(spedingMoney.getValueMonetary(), '-R\$ 50,00');
    });

    test('amountPaid()', () {
      final category = Category(name: 'Cartão', icon: 889899, type: 'income');

      final spedingMoney = SpedingMoney(
        name: 'Anuidade',
        value: 50.0,
        dateRegister: DateTime(2023, 11, 10),
      );
      spedingMoney.category.target = category;

      spedingMoney.amountPaid = 50.0;

      expect(spedingMoney.amountPaid, 50.0);
    });

    test('getBalance()', () {
      final category = Category(name: 'Cartão', icon: 889899, type: 'income');

      final spedingMoney = SpedingMoney(
        name: 'Anuidade',
        value: 50.0,
        dateRegister: DateTime(2023, 11, 10),
      );
      spedingMoney.category.target = category;

      spedingMoney.amountPaid = 40.0;

      expect(spedingMoney.getBalance(), 10.0);
    });

    test('getBalanceMonetary()', () {
      final category = Category(name: 'Cartão', icon: 889899, type: 'income');

      final spedingMoney = SpedingMoney(
        name: 'Anuidade',
        value: 50.0,
        dateRegister: DateTime(2023, 11, 10),
      );
      spedingMoney.category.target = category;

      expect(spedingMoney.getBalanceMonetary(), 'R\$ 50,00');

      spedingMoney.amountPaid = 40.0;

      expect(spedingMoney.getBalanceMonetary(), 'R\$ 10,00');
    });
  });
}
