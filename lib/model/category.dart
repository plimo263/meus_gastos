import 'package:objectbox/objectbox.dart';

/// Classe usada para criar a categoria do recurso. A categoria é o que descreve
/// o recurso como um todo. Ele pode dar uma ideia do recurso ser um pagamento
/// Ou ser algum registro de saida.
@Entity()
class Category {
  @Id()
  int id = 0;

  @Unique()
  String name;
  int icon;
  String color;

  Category({required this.name, required this.icon, this.color = '#000000'});

  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        icon = map['icon'] as int,
        color = map.containsKey('color') ? map['color'] as String : '#000000';
}
