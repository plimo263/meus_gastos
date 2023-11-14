import 'package:flutter/material.dart';

/// Cria valores default da aplicação para gravação no banco de dados
///
initDb() {}

void _createIconsDefault() {
  final List<Map<String, dynamic>> entradas = [
    {
      'icon': Icons.account_balance_wallet.codePoint,
      'name': 'Salário',
      'color': '#4CAF50',
    }
  ];

  final List<Map<String, dynamic>> saidas = [
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
  ];
}
