/// Esta interface é o mais alto nivel da aplicação que determina o recurso
/// registrado.
abstract class ResourcePaid {
  DateTime get dateRegister;

  // Retorna o valor
  double get value;

  /// Retorna o valor do recurso no formato R$ 0,00
  String getValueMonetary();

  /// Retorna a data no formato dd/MM/YY
  String getDateRegister();
}
