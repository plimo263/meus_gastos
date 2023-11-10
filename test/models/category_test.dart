import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/category.dart';

void main() {
  group('Category', () {
    test('constructor', () {
      final category = Category(name: 'Padaria', icon: 984246);
      expect(category, isA<Category>());
    });

    test('fromMap', () {
      final map = {'id': 1, 'name': 'Panificadora', 'icon': 984246};
      final category = Category.fromMap(map);

      expect(category, isA<Category>());
    });
  });
}
