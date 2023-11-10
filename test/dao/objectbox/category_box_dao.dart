import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/model/category.dart';

final category = Category(name: 'Alimentação', icon: 898878);

void main() {
  group('CategoryBoxDao', () {
    final store = null;

    final box = CategoryBoxDao(store);

    test('add', () async {
      final cate = await box.add(category);
      expect(cate, isA<Category>());
    });

    test('getAll', () async {
      final categoryList = await box.getAll();
      expect(categoryList, isA<List<Category>>());
    });

    test('getById', () async {
      final cate = await box.add(category);
      final categoryList = await box.getById(1);
      expect(categoryList, isA<Category>());
    });

    test('update', () async {
      Category cate = await box.add(category);
      cate.name = 'Alimento';
      cate = await box.update(cate);

      expect(cate, isA<Category>());
      expect(cate.name, 'Alimento');
    });

    test('del', () async {
      Category cate = await box.add(category);

      await box.del(cate);

      List<Category> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });

    test('delAll', () async {
      Category cate = await box.add(category);

      await box.delAll(cate);

      List<Category> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });
  });
}
