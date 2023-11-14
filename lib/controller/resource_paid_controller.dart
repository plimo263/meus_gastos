import 'package:meus_gastos/model/interfaces/resource_paid.dart';

/// Interface para interatividades com os recursos de entrada e saida
abstract class ResourcePaidController {
  /// Adiciona um novo recurso financeiro seja entrada ou saida
  Future<void> add(ResourcePaid item);

  /// Exclui um recurso incluso
  void del(ResourcePaid item);

  /// Atualiza um recurso financeiro, seja entrada ou saida
  Future<void> update(ResourcePaid item);

  /// Aplica o filtro de data para mostrar recursos financeiros de um periodo
  Future<void> applyFilterDate(DateTime de, DateTime ate);

  /// Exclui todos os recursos financeiros cadastrados.
  void delAll({clearDB = false});

  /// Obtem todos os recursos financeiros disponiveis no momento
  List<ResourcePaid> getAll();
}
