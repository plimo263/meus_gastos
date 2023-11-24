import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/user_box.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/repository/user_repository.dart';

final user = User(
  '1',
  'email@example.com',
  'Fulano de tal',
  'https://avatar.com.br',
);

void main() {
  late final UserRepository userRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    userRepository = UserRepository(connector.user as UserBoxImpl);
  });

  tearDownAll(() {});
  group('UserRepository', () {
    test('add', () async {
      final userLocal = await userRepository.add(user);
      expect(userLocal, isA<User>());
    });

    test('getByUId', () async {
      final userLocal = await userRepository.getByUId('1');
      expect(userLocal, isA<User>());
    });

    test('update', () async {
      user.name = 'Novo nome';
      final userLocal = await userRepository.update(user);
      expect(userLocal, isA<User>());
    });

    test('del', () async {
      await userRepository.del(user);
      final userLocal = await userRepository.getByUId('1');
      expect(userLocal, isNull);
    });
  });
}
