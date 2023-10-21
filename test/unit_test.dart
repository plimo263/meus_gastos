import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/speding_money.dart';

void main() {
  test('Cria uma categoria', () {
    final obj = Category(name: 'Padaria', icon: '/images/pao.png');

    expect(obj.name, 'Padaria');
    expect(obj.icon, '/images/pao.png');
  });

  test('Cria uma entrada', () {
    final income = FinancialIncome(
      category: Category(name: 'Padaria', icon: '/images/pao.png'),
      name: 'Padaria São João',
      value: 250,
      dateRegister: DateTime.now(),
    );

    expect(income.value, 250);
    expect(income.category.name, 'Padaria');
    expect(income.name, 'Padaria São João');

    expect(income.getValueMonetary(), 'R\$ 250.00');
    expect(
      income.getDateRegister(),
      DateFormat('dd/MM/yy').format(DateTime.now()),
    );
  });

  test('Cria uma saída', () {
    final speding = SpedingMoney(
      category: Category(name: 'Padaria', icon: '/images/pao.png'),
      name: 'Padaria São João',
      value: 250,
      dateRegister: DateTime.now(),
    );

    expect(speding.value, 250);
    expect(speding.category.name, 'Padaria');
    expect(speding.name, 'Padaria São João');

    expect(speding.getValueMonetary(), '-R\$ 250.00');
    expect(
      speding.getDateRegister(),
      DateFormat('dd/MM/yy').format(DateTime.now()),
    );
  });

  test('Abate parte da saída (valor) registrada', () {
    final speding = SpedingMoney(
      category: Category(name: 'Padaria', icon: '/images/pao.png'),
      name: 'Padaria São João',
      value: 250,
      dateRegister: DateTime.now(),
    );

    speding.amountPaid = 100;

    expect(speding.value, 250);
    expect(speding.amountPaid, 100);
    expect(speding.getBalance(), 150);
    expect(speding.getBalanceMonetary(), 'R\$ 150.00');
  });
}
