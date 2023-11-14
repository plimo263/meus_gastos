import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/credit_card.dart';

void main() {
  group('CreditCard', () {
    test('', () {
      final creditCard = CreditCard('Cartão Inter', 15);
      expect(creditCard, isA<CreditCard>());
    });
  });
}
