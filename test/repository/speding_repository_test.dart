import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/speding_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/repository/speding_repository.dart';

final dateRegisterAdd = DateTime(2023, 11, 11);

final spedingMoney = SpedingMoney(
  category: Category(name: 'Salário', icon: 898878),
  name: 'Outubro / 2023',
  value: 1500.0,
  dateRegister: dateRegisterAdd,
);

void main() {
  late final SpedingRepository spedingRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    spedingRepository = SpedingRepository(connector.speding as SpedingBoxImpl);
    // Limpando a casa
    spedingRepository.delAll();
  });

  tearDownAll(() {
    spedingRepository.delAll();
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
