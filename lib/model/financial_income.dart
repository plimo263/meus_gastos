import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:objectbox/objectbox.dart';

import 'interfaces/resource_paid.dart';

/// Esta classe é uma entidade de recursos financeiros, são as entradas
/// de valores no Applicativo. Ela estende [ResourcePaid] para criação
/// dos atributos padrão e formatações de data da entrada e valor monetário.

@Entity()
class FinancialIncome implements ResourcePaid {
  @Id()
  int id = 0;

  String name;
  @override
  double value;

  @override
  @Property(type: PropertyType.date)
  DateTime dateRegister;
  String description;

  final category = ToOne<Category>();
  final user = ToOne<User>();

  FinancialIncome({
    required this.name,
    required this.value,
    required this.dateRegister,
    this.description = '',
  });

  /// Retorna o valor do recurso no formato R$ 0,00
  @override
  String getValueMonetary() {
    return UtilBrasilFields.obterReal(value);
  }

  /// Retorna a data no formato dd/MM/YY
  @override
  String getDateRegister() {
    return DateFormat('dd/MM/yy').format(dateRegister);
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object? other) =>
      other is FinancialIncome && other.name == name;

  @override
  String getTime() {
    return DateFormat('HH:mm').format(dateRegister);
  }
}
