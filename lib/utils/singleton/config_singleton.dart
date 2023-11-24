import 'package:flutter/cupertino.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/utils/categories_default.dart';
import 'package:meus_gastos/utils/prefs.dart';
import 'package:provider/provider.dart';

/// Classe para configurações da aplicacao
class ConfigSingleton {
  DaoConnector? _connectors;
  static ConfigSingleton? _instance;

  ConfigSingleton._internal();

  factory ConfigSingleton() {
    if (_instance != null) {
      return _instance!;
    }
    _instance = ConfigSingleton._internal();

    return _instance!;
  }

  // Inicializa as rotinas default do sistema
  // Como carregamento das categorias (criação caso não existam)
  // Cartões entre outros
  Future<void> init(User user) async {
    final isInitLoad = await Prefs().isLoadInit(user.uid);
    if (!isInitLoad) {
      // Preenche as categorias padrão do sistema
      await _initCategory(user);
      // Marca para que não seja carregado os dados novamente.
      await Prefs().setLoadInit(user.uid);
    }
  }

  /// Realiza a  tarefa inicial de criação das categorias default do sistema
  Future<void> _initCategory(User user) async {
    _connectors ??= await initConnectors();
    CategoryDAO categoryBox = _connectors!.category;

    final categoriesDefault = getCategoriesDefault();
    // Insere as categorias de entrada
    for (Category cate in categoriesDefault['speding'] as List<Category>) {
      cate.user.target = user;
      try {
        await categoryBox.add(cate);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    // Insere as categorias de saida
    for (Category cate in categoriesDefault['income'] as List<Category>) {
      cate.user.target = user;
      try {
        await categoryBox.add(cate);
      } catch (e) {
        //break;
      }
    }
  }

  /// Chama o autopreenchimento dos repositories
  Future<List<void>> initRepositories(BuildContext context, User user) async {
    return Future.wait([
      Provider.of<CategoryProviderController>(context, listen: false)
          .init(user),
      Provider.of<CreditCardProviderController>(context, listen: false)
          .init(user),
      Provider.of<ResourcePaidProviderController>(context, listen: false)
          .init(user),
    ]);
  }
}
