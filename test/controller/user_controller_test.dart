import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/controller/user_controller.dart';
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
  late final UserController userController;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    userController = UserProviderController(
      UserRepository(
        connector.user as UserBoxImpl,
      ),
      null,
    );
  });

  tearDownAll(() {});

  group('UserController', () {
    test('update', () async {
      await userController.update(user);
    });

    test('getUser', () {
      final userLocal = userController.getUser();
      expect(userLocal, isA<User>());
    });

    test('logout', () {
      userController.logout();
    });

    test('delAllDataUser', () {
      userController.delAllDataUser();
      expect(userController.getUser(), isNull);
    });
  });
}
