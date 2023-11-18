import 'package:objectbox/objectbox.dart';

/// Classe para armazenar o usuário autenticado no sistema para uso posterior

@Entity()
class User {
  @Id()
  int id = 0;
  final String uid;
  final String name;
  final String email;
  final String avatar;

  User(this.uid, this.name, this.email, this.avatar);
}
