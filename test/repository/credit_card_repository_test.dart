import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/credit_card_box.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/repository/credit_card_repository.dart';

final creditCard = CreditCard('Banco Inter', 15);

void main() {
  late final CreditCardRepository creditCardRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    creditCardRepository =
        CreditCardRepository(connector.creditCard as CreditCardBoxImpl);
    // Limpando a casa
    creditCardRepository.delAll();
  });

  tearDownAll(() {
    creditCardRepository.delAll();
  });
  group('CreditCardRepository', () {
    test('add', () async {
      final cate = await creditCardRepository.add(creditCard);
      expect(cate, isA<CreditCard>());
    });

    test('getAll', () async {
      final creditCardList = await creditCardRepository.getAll();
      expect(creditCardList.isEmpty, isFalse);
    });

    test('update', () async {
      creditCard.name = 'Novo nome';
      final cate = await creditCardRepository.update(creditCard);
      expect(cate, isA<CreditCard>());
    });

    test('delAll', () async {
      await creditCardRepository.delAll();
      final cateList = await creditCardRepository.getAll();
      expect(cateList.isEmpty, isTrue);
    });
  });
}
