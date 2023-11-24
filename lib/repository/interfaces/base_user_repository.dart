import 'package:meus_gastos/model/user.dart';

/// Interface para definir tarefas basicas comuns ao registro do usuario
abstract class BaseUserRepository {
  /// Recupera por uid
  Future<User?> getByUId(String uid);

  /// Adiciona um novo item
  Future<User> add(User item);

  /// Atualiza um item existente
  Future<User> update(User item);

  /// Exclui um item existente
  Future<void> del(User item);
}
