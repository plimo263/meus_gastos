import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';

import 'category.dart';

/// Esta abstração é o mais alto nivel da aplicação que determina o recurso
/// registrado. Use-o para estender seus recursos.
abstract class ResourcePaid {
  Category category;
  String name;
  double value;
  DateTime dateRegister;
  String description;

  ResourcePaid({
    required this.category,
    required this.name,
    required this.value,
    required this.dateRegister,
    this.description = '',
  });

  /// Retorna o valor do recurso no formato R$ 0,00
  String getValueMonetary() {
    return UtilBrasilFields.obterReal(value);
  }

  /// Retorna a data no formato dd/MM/YY
  String getDateRegister() {
    return DateFormat('dd/MM/yy').format(dateRegister);
  }
}
