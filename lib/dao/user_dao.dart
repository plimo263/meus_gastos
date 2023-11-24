import 'package:meus_gastos/model/user.dart';

/// Abstração para os usuarios a serem salvos no db
abstract class UserDAO {
  /// Inicializador ao conector de recurso do db
  Future<void> init();

  /// Recupera por uid
  Future<User?> getByUId(String uid);

  /// Adiciona um novo item
  Future<User> add(User item);

  /// Atualiza um item existente
  Future<User> update(User item);

  /// Exclui um item existente
  Future<void> del(User item);
}
