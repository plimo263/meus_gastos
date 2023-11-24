import 'package:meus_gastos/dao/user_dao.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';
import 'package:meus_gastos/model/user.dart';

class UserBoxImpl implements UserDAO {
  late final Store store;
  late final Box<User> box;

  UserBoxImpl(this.store) {
    box = store.box<User>();
  }

  @override
  Future<User> add(User item) async {
    int indice = await box.putAsync(item);
    item.id = indice;
    return item;
  }

  @override
  Future<void> del(User item) async {
    await box.removeAsync(item.id);
  }

  @override
  Future<User?> getByUId(String uid) async {
    final query = box.query(User_.uid.equals(uid)).build();
    final users = await query.findAsync();

    if (users.isEmpty) {
      return null;
    }
    return users[0];
  }

  @override
  Future<void> init() async {}

  @override
  Future<User> update(User item) async {
    await box.putAsync(item);
    return item;
  }
}
