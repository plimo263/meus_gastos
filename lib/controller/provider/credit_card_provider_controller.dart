import 'package:flutter/material.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/utils/singleton/login_singleton.dart';
import '../../model/credit_card.dart';
import '../../repository/credit_card_repository.dart';
import '../credit_card_controller.dart';

class CreditCardProviderController extends ChangeNotifier
    implements CreditCardController {
  final List<CreditCard> _creditCards;
  final CreditCardRepository creditCardRepository;
  CreditCardProviderController(
    this.creditCardRepository,
    this._creditCards,
  );

  @override
  Future<void> add(CreditCard creditCard) async {
    //
    final cate = await creditCardRepository.add(creditCard);
    _creditCards.add(cate);
    notifyListeners();
  }

  @override
  void del(CreditCard creditCard) {
    _creditCards.remove(creditCard);
    //
    creditCardRepository.del(creditCard);
    notifyListeners();
  }

  @override
  void delAll({clearDB = false}) {
    _creditCards.clear();
    if (clearDB) {
      creditCardRepository.delAll();
    }
    notifyListeners();
  }

  @override
  List<CreditCard> getAll() {
    return _creditCards;
  }

  @override
  Future<void> update(CreditCard creditCard) async {
    final List<CreditCard> creditCardList = _creditCards.map((ele) {
      if (ele == creditCard) {
        return creditCard;
      }
      return ele;
    }).toList();

    _creditCards.clear();
    _creditCards.addAll(creditCardList);
    //
    creditCardRepository.update(creditCard);
    notifyListeners();
  }

  @override
  Future<void> init(User user) async {
    List<CreditCard> creditCardList =
        await creditCardRepository.getAllByUser(user);
    _creditCards.clear();
    _creditCards.addAll(creditCardList);
    notifyListeners();
  }
}
