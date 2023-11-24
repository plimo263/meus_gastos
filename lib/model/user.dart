import 'package:objectbox/objectbox.dart';

/// Classe para armazenar o usuário autenticado no sistema para uso posterior

@Entity()
class User {
  @Id()
  int id = 0;

  @Unique()
  String uid;
  String name;
  String email;
  String avatar;

  User(this.uid, this.name, this.email, this.avatar);
}
