import 'resource_paid.dart';

/// Esta classe é uma entidade de recursos financeiros, são as entradas
/// de valores no Applicativo. Ela estende [ResourcePaid] para criação
/// dos atributos padrão e formatações de data da entrada e valor monetário.
class FinancialIncome extends ResourcePaid {
  FinancialIncome({
    required super.category,
    required super.name,
    required super.value,
    required super.dateRegister,
  });
}
