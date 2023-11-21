import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/credit_card_box.dart';
import 'package:meus_gastos/model/credit_card.dart';

final creditCard = CreditCard('Banco Inter', 15, 20);

void main() {
  late final CreditCardBoxImpl creditCardBox;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    creditCardBox = connector.creditCard as CreditCardBoxImpl;
    // Limpando a casa
    await creditCardBox.delAll();
  });

  tearDownAll(() async {
    await creditCardBox.delAll();
  });

  group('CreditCardBoxImpl', () {
    test('add', () async {
      final box = creditCardBox;
      final cate = await box.add(creditCard);
      expect(cate, isA<CreditCard>());
    });

    test('getAll', () async {
      final box = creditCardBox;
      final creditCardList = await box.getAll();
      expect(creditCardList, isA<List<CreditCard>>());
    });

    test('getById', () async {
      final box = creditCardBox;
      await box.add(creditCard);
      final creditCardList = await box.getById(1);
      expect(creditCardList, isA<CreditCard>());
    });

    test('update', () async {
      final box = creditCardBox;
      CreditCard cate = await box.add(creditCard);
      cate.name = 'Alimento';
      cate = await box.update(cate);

      expect(cate, isA<CreditCard>());
      expect(cate.name, 'Alimento');
    });

    test('del', () async {
      final box = creditCardBox;
      CreditCard cate = await box.add(creditCard);

      await box.del(cate);

      List<CreditCard> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });

    test('delAll', () async {
      final box = creditCardBox;
      await box.add(creditCard);

      await box.delAll();

      List<CreditCard> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });
  });
}
