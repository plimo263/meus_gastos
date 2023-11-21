import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/controller/credit_card_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/credit_card_box.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/repository/credit_card_repository.dart';

void main() {
  late final CreditCardController creditCardController;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    creditCardController = CreditCardProviderController(
      CreditCardRepository(
        connector.creditCard as CreditCardBoxImpl,
      ),
      <CreditCard>[],
    );
    // Limpando a casa
    creditCardController.delAll(clearDB: true);
  });

  tearDownAll(() {
    creditCardController.delAll(clearDB: true);
  });

  group('CreditCardController', () {
    test('add', () async {
      final creditCard = CreditCard('Banco inter', 15, 20);
      await creditCardController.add(creditCard);
    });

    test('update', () async {
      final creditCardList = creditCardController.getAll();
      final creditCard = creditCardList[0];
      creditCard.name = 'Padaria';
      await creditCardController.update(creditCard);
    });

    test('getAll', () {
      final creditCardList = creditCardController.getAll();
      expect(creditCardList, isNotEmpty);
    });

    test('del', () {
      final creditCardList = creditCardController.getAll();
      final creditCard = creditCardList[0];
      creditCardController.del(creditCard);
    });

    test('delAll', () {
      creditCardController.delAll();
      expect(creditCardController.getAll(), isEmpty);
    });
  });
}
