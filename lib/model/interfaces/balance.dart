/// Interface que solicita a criação do getBalance que deve ser
/// usado para obter o total de uma despesa menos o total que já foi pago
/// desta receita.
abstract class Balance {
  // ignore: unused_field
  late double _amountPaid;

  double getBalance();
  String getBalanceMonetary();
}
