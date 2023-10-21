import 'balance.dart';
import 'resource_paid.dart';

/// Registra as despesas do aplicativo, as saidas financeiras propriamente dito
/// Ele estende de [ResourcePaid] para criação dos atributos padrão
/// e formatações de data da entrada e valor monetário.
class SpedingMoney extends ResourcePaid implements Balance {
  @override
  double _amountPaid = 0.0;

  SpedingMoney({
    required super.category,
    required super.name,
    required super.value,
    required super.dateRegister,
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
    return '-${super.getValueMonetary()}';
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
    return 'R\$ ${(value - amountPaid).toStringAsFixed(2)}';
  }
}
