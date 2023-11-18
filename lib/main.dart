import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/repository/credit_card_repository.dart';
import 'package:meus_gastos/repository/income_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';
import 'package:meus_gastos/screen/routes.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';
import 'package:meus_gastos/themes/theme_default.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final connectors = await initConnectors();

  runApp(MyApp(connectors: connectors));
}

class MyApp extends StatelessWidget {
  final DaoConnector connectors;
  const MyApp({super.key, required this.connectors});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProviderController(
            CategoryRepository(connectors.category),
            [],
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
      ),
    );
  }
}
