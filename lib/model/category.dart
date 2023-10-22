/// Classe usada para criar a categoria do recurso. A categoria é o que descreve
/// o recurso como um todo. Ele pode dar uma ideia do recurso ser um pagamento
/// Ou ser algum registro de saida.
class Category<T> {
  int _id = 0;
  late String _name;
  late T _icon;

  Category({required String name, required T icon}) {
    this._name = name;
    this._icon = icon;
  }

  set id(inId) {
    _id = inId;
  }

  int get id {
    return _id;
  }

  set name(inName) {
    _name = inName;
  }

  String get name {
    return _name;
  }

  set icon(inIcon) {
    _icon = inIcon;
  }

  T get icon {
    return _icon;
  }
}
