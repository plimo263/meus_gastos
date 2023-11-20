import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';

/// Recupera as categorias padrão, estas categorias não podem ser excluidas
/// apenas atribuidas
Map<String, List<Category>> getCategoriesDefault() {
  final List<Category> incomes = [
    Category(
      name: 'Salário',
      icon: Icons.account_balance_wallet.codePoint,
      color: '#4CAF50',
      type: 'income',
    ),
    // Outros. Nao excluivel
    Category(
      icon: Icons.question_mark.codePoint,
      name: 'Outros',
      color: '#4CAF50',
      type: 'income',
    ),
  ];

  final List<Category> spedings = [
    // Combustivel
    {
      'icon': Icons.local_gas_station.codePoint,
      'name': 'Combustivel',
      'color': '#EF5350'
    },
    // Alimentacao
    {
      'icon': Icons.fastfood.codePoint,
      'name': 'Alimentação',
      'color': '#EF5350'
    },
    // Compras
    {
      'icon': Icons.local_grocery_store.codePoint,
      'name': 'Compras',
      'color': '#EF5350'
    },
    // Pagamento a pessoas
    {
      'icon': Icons.sports_kabaddi.codePoint,
      'name': 'Pagamento a terceiros',
      'color': '#EF5350'
    },
    // Presente
    {
      'icon': Icons.redeem.codePoint,
      'name': 'Presente',
      'color': '#EF5350',
    },
    // Casa
    {
      'icon': Icons.home.codePoint,
      'name': 'Aluguel / Prestação casa',
      'color': '#EF5350'
    },
    // Conta de luz
    {
      'icon': Icons.wb_incandescent.codePoint,
      'name': 'Conta de luz',
      'color': '#EF5350'
    },
    // Conta de agua
    {
      'icon': Icons.water_drop.codePoint,
      'name': 'Conta de água',
      'color': '#EF5350'
    },
    // Cartao de credito
    {
      'icon': Icons.credit_card.codePoint,
      'name': 'Cartao de crédito',
      'color': '#EF5350'
    },
    // Mecanico
    {
      'icon': Icons.build.codePoint,
      'name': 'Mecânico',
      'color': '#EF5350',
    },
    // Veterinario
    {
      'icon': Icons.pets.codePoint,
      'name': 'Veterinário',
      'color': '#EF5350',
    },
    // Medico
    {
      'icon': Icons.health_and_safety.codePoint,
      'name': 'Médico',
      'color': '#EF5350'
    },
    // Moto
    {
      'icon': Icons.sports_motorsports.codePoint,
      'name': 'Motocicleta',
      'color': '#EF5350'
    },
    // Lazer
    {
      'icon': Icons.sports_soccer.codePoint,
      'name': 'Lazer',
      'color': '#EF5350'
    },
    // Viagem
    {
      'icon': Icons.flight_takeoff.codePoint,
      'name': 'Viagem',
      'color': '#EF5350'
    },
    // Educacao
    {
      'icon': Icons.school.codePoint,
      'name': 'Educação',
      'color': '#EF5350',
    },
    // Outros. Nao excluivel
    {
      'icon': Icons.question_mark.codePoint,
      'name': 'Outros',
      'color': '#EF5350',
    },
  ]
      .map<Category>(
        (e) => Category(
          name: e['name'] as String,
          icon: e['icon'] as int,
          color: e['color'] as String,
          type: 'speding',
        ),
      )
      .toList();

  return {'income': incomes, 'speding': spedings};
}
