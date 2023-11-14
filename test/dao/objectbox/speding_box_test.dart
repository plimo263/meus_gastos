import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/dao/objectbox/speding_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/speding_money.dart';

Category category = Category(name: 'Salário', icon: 898878);
SpedingMoney spedingMoney = SpedingMoney(
    name: 'Outubro / 2023', value: 1500.0, dateRegister: DateTime.now());

void main() {
  late final SpedingBoxImpl spedingBox;
  late final CategoryBoxImpl categoryBox;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    spedingBox = connector.speding as SpedingBoxImpl;
    categoryBox = connector.category as CategoryBoxImpl;
    // Limpando a casa
    await categoryBox.delAll();
    await spedingBox.delAll();

    category = await categoryBox.add(category);
    spedingMoney.category.target = category;
  });

  tearDownAll(() async {
    await categoryBox.delAll();
    await spedingBox.delAll();
  });

  group('SpedingBoxDao', () {
    test('add', () async {
      final box = spedingBox;
      final speding = await box.add(spedingMoney);
      expect(speding, isA<SpedingMoney>());
    });

    test('getAll', () async {
      final box = spedingBox;
      final spedingMoneyList = await box.getAll();
      expect(spedingMoneyList, isA<List<SpedingMoney>>());
    });

    test('getById', () async {
      final box = spedingBox;
      await box.add(spedingMoney);
      final spedingMoneyList = await box.getById(1);
      expect(spedingMoneyList, isA<SpedingMoney>());
    });

    test('update', () async {
      final box = spedingBox;
      SpedingMoney speding = await box.add(spedingMoney);
      speding.name = 'Alimento';
      speding = await box.update(speding);

      expect(speding, isA<SpedingMoney>());
      expect(speding.name, 'Alimento');
    });

    test('del', () async {
      final box = spedingBox;
      SpedingMoney speding = await box.add(spedingMoney);
      await box.del(speding);
      List<SpedingMoney> spedingList = await box.getAll();
      expect(spedingList.isEmpty, isTrue);
    });

    test('delAll', () async {
      final box = spedingBox;
      await box.add(spedingMoney);
      await box.delAll();
      List<SpedingMoney> spedingList = await box.getAll();
      expect(spedingList.isEmpty, isTrue);
    });
  });
}
