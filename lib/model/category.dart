import 'package:meus_gastos/model/user.dart';
import 'package:objectbox/objectbox.dart';

/// Classe usada para criar a categoria do recurso. A categoria é o que descreve
/// o recurso como um todo. Ele pode dar uma ideia do recurso ser um pagamento
/// Ou ser algum registro de saida.
@Entity()
class Category {
  @Id()
  int id = 0;

  String name;
  int icon;
  String color;
  String type;
  final user = ToOne<User>();

  Category(
      {required this.name,
      required this.icon,
      required this.type,
      this.color = '#000000'});

  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        icon = map['icon'] as int,
        type = (map['type'] as String),
        color = map.containsKey('color') ? map['color'] as String : '#000000';

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object? other) => other is Category && other.name == name;
}
