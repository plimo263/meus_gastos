import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/user_controller.dart';
import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/dao/credit_card_dao.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/income_dao.dart';
import 'package:meus_gastos/dao/speding_dao.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/repository/user_repository.dart';

class UserProviderController extends ChangeNotifier implements UserController {
  User? _user;
  final UserRepository userRepository;
  UserProviderController(
    this.userRepository,
    this._user,
  );

  // Todas as categorias
  Future<void> _delCategories(CategoryDAO connector) async {
    final List<Category> listCategory = await connector.getAllByUser(_user!);
    for (Category category in listCategory) {
      connector.del(category);
    }
  }

  // Exclui todas as saidas relacionadas ao usuario
  Future<void> _delSpedings(SpedingDAO connector) async {
    final List<SpedingMoney> listSpending =
        await connector.getAllByUser(_user!);
    for (SpedingMoney speding in listSpending) {
      connector.del(speding);
    }
  }

  // Exclui todas as entradas relacionadas ao usuario
  Future<void> _delIncomes(IncomeDAO connector) async {
    final List<FinancialIncome> listIncome =
        await connector.getAllByUser(_user!);
    for (FinancialIncome income in listIncome) {
      connector.del(income);
    }
  }

  // Exclui todos os cartoes de credito relacionados ao usuario
  Future<void> _delCreditCards(CreditCardDao connector) async {
    final List<CreditCard> listCreditCard =
        await connector.getAllByUser(_user!);
    for (CreditCard creditCard in listCreditCard) {
      connector.del(creditCard);
    }
  }

  @override
  Future<void> delAllDataUser() async {
    final connectors = await initConnectors();
    if (_user != null) {
      // Excluir todas as entradas
      await _delIncomes(connectors.income);
      // Excluir todas as saidas
      await _delSpedings(connectors.speding);
      // Excluir todos os cartoes
      await _delCreditCards(connectors.creditCard);
      // Excluir todas as categorias do usuario
      await _delCategories(connectors.category);

      // Exclui o usuario de vez
      userRepository.del(_user!);
    }

    // Faz o logout
    logout();
  }

  @override
  User? getUser() {
    return _user;
  }

  @override
  Future<void> init(User inUser) async {
    // Recupera o user
    final userLocal = await userRepository.getByUId(inUser.uid);
    if (userLocal == null) {
      _user = await userRepository.add(inUser);
    } else {
      _user = userLocal;
    }
    notifyListeners();
  }

  @override
  void logout() {
    _user = null;
    notifyListeners();
  }

  @override
  Future<void> update(User user) async {
    final userLocal = await userRepository.update(user);
    _user = userLocal;
    notifyListeners();
  }
}
