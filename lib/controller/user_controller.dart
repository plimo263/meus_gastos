import 'package:meus_gastos/model/user.dart';

/// Interface para manipulação do usuario
abstract class UserController {
  /// Rotina de inicializacao no controller
  Future<void> init(User inUser);

  /// Para recuperar o usuario logado
  User? getUser();

  /// Atualiza dados do usuario logado
  Future<void> update(User user);

  /// Faz logout do usuario logado
  void logout();

  /// Exclui todos os dados do usuário
  Future<void> delAllDataUser();
}
