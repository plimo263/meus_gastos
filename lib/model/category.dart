/// Classe usada para criar a categoria do recurso. A categoria é o que descreve
/// o recurso como um todo. Ele pode dar uma ideia do recurso ser um pagamento
/// Ou ser algum registro de saida.
class Category {
  int id = 0;
  String name;
  int icon;

  Category({required this.name, required this.icon});

  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        icon = map['icon'] as int;
}
