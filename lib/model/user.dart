import 'package:objectbox/objectbox.dart';

/// Classe para armazenar o usuário autenticado no sistema para uso posterior

@Entity()
class User {
  @Id()
  int id = 0;
  final String name;
  final String email;
  final String avatar;

  User(this.id, this.name, this.email, this.avatar);
}
