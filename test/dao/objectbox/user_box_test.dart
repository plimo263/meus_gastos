import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/user_box.dart';
import 'package:meus_gastos/model/user.dart';

final user = User(
  '1',
  'email@example.com',
  'Fulano de tal',
  'https://avatar.com.br',
);

void main() {
  late final UserBoxImpl userBox;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    userBox = connector.user as UserBoxImpl;
    // // Limpando a casa
    // await userBox.del(user);
  });

  tearDownAll(() async {
    // await userBox.del(user);
  });

  group('UserBoxImpl', () {
    test('add', () async {
      final box = userBox;
      final userLocal = await box.add(user);
      expect(userLocal, isA<User>());
    });

    test('getByUId', () async {
      final box = userBox;
      await box.add(user);
      final userLocal = await box.getByUId('1');
      expect(userLocal, isA<User>());
    });

    test('update', () async {
      final box = userBox;
      User userLocal = await box.add(user);
      userLocal.name = 'Alimento';
      userLocal = await box.update(userLocal);

      expect(userLocal, isA<User>());
      expect(userLocal.name, 'Alimento');
    });

    test('del', () async {
      final box = userBox;
      User userLocal = await box.add(user);

      await box.del(userLocal);

      User? userLocalI = await box.getByUId('1');
      expect(userLocalI, isNull);
    });
  });
}
