import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/dao/credit_card_dao.dart';
import 'package:meus_gastos/dao/income_dao.dart';
import 'package:meus_gastos/dao/objectbox/credit_card_box.dart';
import 'package:meus_gastos/dao/objectbox/objectboxsingleton.dart';
import 'package:meus_gastos/dao/objectbox/user_box.dart';
import 'package:meus_gastos/dao/speding_dao.dart';
import 'package:meus_gastos/dao/user_dao.dart';
import 'objectbox/category_box.dart';
import 'objectbox/income_box.dart';
import 'objectbox/speding_box.dart';

/// Os conectores padrão para usar nos repositorios.
/// Alterando um conector aqui os outros pontos que
/// usam este recurso não serão afetados pois aceitam
/// as implementações de DAO.

/// Classe usada para acessar os DaoConnectors por atributo
class DaoConnector {
  CategoryDAO? _category;
  IncomeDAO? _income;
  SpedingDAO? _speding;
  CreditCardDao? _creditCard;
  UserDAO? _user;

  static final DaoConnector _instance = DaoConnector._init();

  factory DaoConnector() {
    return _instance;
  }

  CategoryDAO get category {
    return _category!;
  }

  set category(CategoryDAO value) {
    _category ??= value;
  }

  IncomeDAO get income {
    return _income!;
  }

  set income(IncomeDAO value) {
    _income ??= value;
  }

  SpedingDAO get speding {
    return _speding!;
  }

  set speding(SpedingDAO value) {
    _speding ??= value;
  }

  CreditCardDao get creditCard {
    return _creditCard!;
  }

  set creditCard(CreditCardDao value) {
    _creditCard ??= value;
  }

  UserDAO get user {
    return _user!;
  }

  set user(UserDAO value) {
    _user ??= value;
  }

  DaoConnector._init();
}

/// Retorna todos os conectores DAO
Future<DaoConnector> initConnectors({String? directory}) async {
  ObjectBox objBox = ObjectBox();
  objBox.directory = directory;
  final store = await objBox.store;
  final daoConnector = DaoConnector();

  daoConnector.category = CategoryBoxImpl(store);
  daoConnector.income = IncomeBoxImpl(store);
  daoConnector.speding = SpedingBoxImpl(store);
  daoConnector.creditCard = CreditCardBoxImpl(store);
  daoConnector.user = UserBoxImpl(store);

  return daoConnector;
}
