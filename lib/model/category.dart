/// Classe usada para criar a categoria do recurso. A categoria é o que descreve
/// o recurso como um todo. Ele pode dar uma ideia do recurso ser um pagamento
/// Ou ser algum registro de saida.
class Category<T> {
  final String name;
  final T icon;

  Category({required this.name, required this.icon});
}
