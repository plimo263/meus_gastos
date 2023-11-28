import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/repository/category_repository.dart';
import 'package:meus_gastos/repository/credit_card_repository.dart';
import 'package:meus_gastos/repository/income_repository.dart';
import 'package:meus_gastos/repository/speding_repository.dart';
import 'package:meus_gastos/repository/user_repository.dart';
import 'package:meus_gastos/screen/routes.dart';
import 'package:meus_gastos/screen/splash/splash_screen.dart';
import 'package:meus_gastos/themes/theme_default.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;

  await dotenv.load(fileName: ".env");
  final connectors = await initConnectors();

  runApp(
    MyApp(
      connectors: connectors,
    ),
  );
}

class MyApp extends StatelessWidget {
  final DaoConnector connectors;
  const MyApp({
    super.key,
    required this.connectors,
  });

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
        ChangeNotifierProvider(
          create: (_) => UserProviderController(
            UserRepository(connectors.user),
            null,
          ),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: theme,
        initialRoute: SplashScreen.routeName,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'), // English
        ],
      ),
    );
  }
}
