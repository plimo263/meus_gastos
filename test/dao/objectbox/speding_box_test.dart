import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/speding_money.dart';

final spedingMoney = SpedingMoney(
    category: Category(name: 'Salário', icon: 898878),
    name: 'Outubro / 2023',
    value: 1500.0,
    dateRegister: DateTime.now());

void main() {
  group('SpedingBoxDao', () {
    final store = null;

    final box = SpedingBoxDao(store);

    test('add', () async {
      final speding = await box.add(spedingMoney);
      expect(speding, isA<SpedingMoney>());
    });

    test('getAll', () async {
      final spedingMoneyList = await box.getAll();
      expect(spedingMoneyList, isA<List<SpedingMoney>>());
    });

    test('getById', () async {
      final speding = await box.add(spedingMoney);
      final spedingMoneyList = await box.getById(1);
      expect(spedingMoneyList, isA<SpedingMoney>());
    });

    test('update', () async {
      SpedingMoney speding = await box.add(spedingMoney);
      speding.name = 'Alimento';
      speding = await box.update(speding);

      expect(speding, isA<SpedingMoney>());
      expect(speding.name, 'Alimento');
    });

    test('del', () async {
      SpedingMoney speding = await box.add(spedingMoney);

      await box.del(speding);

      List<SpedingMoney> spedingList = await box.getAll();
      expect(spedingList.isEmpty, isTrue);
    });

    test('delAll', () async {
      SpedingMoney speding = await box.add(spedingMoney);

      await box.delAll(speding);

      List<SpedingMoney> spedingList = await box.getAll();
      expect(spedingList.isEmpty, isTrue);
    });
  });
}
