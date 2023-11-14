import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/user.dart';

void main() {
  group('User', () {
    test('Instance of User', () {
      final user = User(
          1, 'email@example.com', 'Fulano de tal', 'https://avatar.com.br');
      expect(user, isA<User>());
    });
  });
}
