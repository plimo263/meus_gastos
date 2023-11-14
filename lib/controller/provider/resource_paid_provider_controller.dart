import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/resource_paid_controller.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/interfaces/resource_paid.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/repository/income_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';

class ResourcePaidProviderController extends ChangeNotifier
    implements ResourcePaidController {
  final IncomeRepository incomeRepository;
  final SpedingRepository spedingRepository;
  final List<ResourcePaid> _resourcePaid;

  ResourcePaidProviderController(
    this.incomeRepository,
    this.spedingRepository,
    this._resourcePaid,
  );

  @override
  Future<void> add(ResourcePaid item) async {
    if (item is FinancialIncome) {
      await incomeRepository.add(item);
    } else if (item is SpedingMoney) {
      await spedingRepository.add(item);
    } else {
      throw Exception('Tipo de recurso financeiro não encontrado.');
    }
    _resourcePaid.add(item);
    notifyListeners();
  }

  @override
  Future<void> applyFilterDate(DateTime de, DateTime ate) async {
    final List<SpedingMoney> spendingList =
        await spedingRepository.getAllBetweenDates(
      de,
      ate,
    );

    final List<FinancialIncome> incomeList =
        await incomeRepository.getAllBetweenDates(
      de,
      ate,
    );
    // Mescla as duas listas
    _resourcePaid.clear();

    _resourcePaid.addAll(spendingList);
    _resourcePaid.addAll(incomeList);

    // Realiza uma ordenacao na lista
    _resourcePaid.sort((a, b) {
      return a.dateRegister.compareTo(b.dateRegister);
    });

    notifyListeners();
  }

  @override
  void del(ResourcePaid item) {
    if (item is FinancialIncome) {
      incomeRepository.del(item);
    } else if (item is SpedingMoney) {
      spedingRepository.del(item);
    }
    _resourcePaid.remove(item);
    notifyListeners();
  }

  @override
  void delAll({clearDB = false}) {
    if (clearDB) {
      incomeRepository.delAll();
      spedingRepository.delAll();
    }
    _resourcePaid.clear();
    notifyListeners();
  }

  @override
  List<ResourcePaid> getAll() {
    return _resourcePaid;
  }

  @override
  Future<void> update(ResourcePaid item) async {
    if (item is FinancialIncome) {
      await incomeRepository.update(item);
    } else if (item is SpedingMoney) {
      await spedingRepository.update(item);
    } else {
      throw Exception('Tipo de recurso financeiro não encontrado.');
    }
    //
    List<ResourcePaid> listInternal = _resourcePaid.map((resource) {
      if (item == resource) {
        return item;
      }
      return resource;
    }).toList();

    _resourcePaid.clear();
    _resourcePaid.addAll(listInternal);

    notifyListeners();
  }
}
