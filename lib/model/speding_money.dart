import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

import 'balance.dart';
import 'category.dart';
import 'resource_paid.dart';

/// Registra as despesas do aplicativo, as saidas financeiras propriamente dito
/// Ele estende de [ResourcePaid] para criação dos atributos padrão
/// e formatações de data da entrada e valor monetário.

@Entity()
class SpedingMoney implements ResourcePaid, Balance {
  @Id()
  int id = 0;

  @Transient()
  Category? category;

  final categoryRef = ToOne<Category>();

  String name;
  double value;

  @Property(type: PropertyType.date)
  DateTime dateRegister;
  String description;

  @override
  double _amountPaid = 0.0;

  SpedingMoney({
    required this.name,
    required this.value,
    required this.dateRegister,
    this.description = '',
    this.category,
  });

  /// Atualiza o valor da quantia paga, desde que ela não seja superior
  /// Ao valor da despesa registrado.
  set amountPaid(double newAmountPaid) {
    if (newAmountPaid > value) {
      throw Exception('O valor enviado é superior ao valor da despesa');
    }
    _amountPaid = newAmountPaid;
  }

  double get amountPaid {
    return _amountPaid;
  }

  @override
  String getValueMonetary() {
    return '-${UtilBrasilFields.obterReal(value)}';
  }

  /// Retorna a data no formato dd/MM/YY
  @override
  String getDateRegister() {
    return DateFormat('dd/MM/yy').format(dateRegister);
  }

  /// Retorna o valor restante do que falta a ser abatido para que a despesa
  /// seja totalmente paga
  @override
  double getBalance() {
    return value - amountPaid;
  }

  /// Retorna o valor restante do que falta a ser abatido para que a despesa
  /// seja totalmente paga no formato R$ 0,00
  @override
  String getBalanceMonetary() {
    return UtilBrasilFields.obterReal(value - amountPaid);
  }
}
