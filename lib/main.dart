import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/dao/category_dao.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/repository/credit_card_repository.dart';
import 'package:meus_gastos/repository/income_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';
import 'package:meus_gastos/screen/routes.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';
import 'package:meus_gastos/themes/theme_default.dart';
import 'package:meus_gastos/utils/categories_default.dart';
import 'package:provider/provider.dart';

/// Realiza a  tarefa inicial de criação das categorias default do sistema
Future<void> initCategory(CategoryDAO categoryBox) async {
  final categoriesDefault = getCategoriesDefault();
  // Insere as categorias de entrada
  for (Category cate in categoriesDefault['speding'] as List<Category>) {
    try {
      await categoryBox.add(cate);
    } catch (e) {
      //break;
    }
  }
  // Insere as categorias de saida
  for (Category cate in categoriesDefault['income'] as List<Category>) {
    try {
      await categoryBox.add(cate);
    } catch (e) {
      //break;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;

  await dotenv.load(fileName: ".env");
  final connectors = await initConnectors();
  // Preenche e recupera as categorias padrão do sistema
  await initCategory(connectors.category);
  final categoriesList = await connectors.category.getAll();

  runApp(MyApp(connectors: connectors, categories: categoriesList));
}

class MyApp extends StatelessWidget {
  final DaoConnector connectors;
  final List<Category> categories;
  const MyApp({
    super.key,
    required this.connectors,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProviderController(
            CategoryRepository(connectors.category),
            categories,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CreditCardProviderController(
            CreditCardRepository(connectors.creditCard),
            [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ResourcePaidProviderController(
            IncomeRepository(connectors.income),
            SpedingRepository(connectors.speding),
            [],
          ),
        ),
      ],
      child: MaterialApp(
        theme: theme,
        initialRoute: SplashScreen.routeName,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
