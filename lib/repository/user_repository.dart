import 'package:meus_gastos/dao/user_dao.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/repository/interfaces/base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  late final UserDAO userBox;

  UserRepository(this.userBox);

  @override
  Future<User> add(User item) async {
    return await userBox.add(item);
  }

  @override
  Future<void> del(User item) async {
    await userBox.del(item);
  }

  @override
  Future<User?> getByUId(String uid) async {
    return await userBox.getByUId(uid);
  }

  @override
  Future<User> update(User item) async {
    return await userBox.update(item);
  }
}
