import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/dao/objectbox/speding_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';

final dateRegisterAdd = DateTime(2023, 11, 11);

SpedingMoney spedingMoney = SpedingMoney(
  name: 'Outubro / 2023',
  value: 1500.0,
  dateRegister: dateRegisterAdd,
);

Category category = Category(name: 'Salário', icon: 898878, type: 'income');

void main() {
  late final SpedingRepository spedingRepository;
  late final CategoryRepository categoryRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    spedingRepository = SpedingRepository(connector.speding as SpedingBoxImpl);
    categoryRepository = CategoryRepository(
      connector.category as CategoryBoxImpl,
    );
    // Limpando a casa
    await categoryRepository.delAll();
    await spedingRepository.delAll();

    category = await categoryRepository.add(category);
    spedingMoney.category.target = category;
  });

  tearDownAll(() async {
    await categoryRepository.delAll();
    await spedingRepository.delAll();
  });

  group('SpedingRepository', () {
    test('add', () async {
      final income = await spedingRepository.add(spedingMoney);
      expect(income, isA<SpedingMoney>());
    });

    test('getAll', () async {
      final spedingList = await spedingRepository.getAll();
      expect(spedingList.isNotEmpty, isTrue);
    });

    test('update', () async {
      spedingMoney.name = 'Padaria';
      final speding = await spedingRepository.update(spedingMoney);

      expect(speding.name, 'Padaria');
    });

    test('getAllBetweenDates', () async {
      List<SpedingMoney> spedingList =
          await spedingRepository.getAllBetweenDates(
        dateRegisterAdd,
        dateRegisterAdd,
      );
      expect(spedingList.isNotEmpty, isTrue);
    });

    test('delAll', () async {
      await spedingRepository.delAll();
      final spedingList = await spedingRepository.getAll();
      expect(spedingList.isEmpty, isTrue);
    });
  });
}
