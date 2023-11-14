import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/model/category.dart';

final category = Category(name: 'Alimentação', icon: 898878);

void main() {
  late final CategoryBoxImpl categoryBox;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    categoryBox = connector.category as CategoryBoxImpl;
    // Limpando a casa
    await categoryBox.delAll();
  });

  tearDownAll(() async {
    await categoryBox.delAll();
  });

  group('CategoryBoxImpl', () {
    test('add', () async {
      final box = categoryBox;
      final cate = await box.add(category);
      expect(cate, isA<Category>());
    });

    test('getAll', () async {
      final box = categoryBox;
      final categoryList = await box.getAll();
      expect(categoryList, isA<List<Category>>());
    });

    test('getById', () async {
      final box = categoryBox;
      await box.add(category);
      final categoryList = await box.getById(1);
      expect(categoryList, isA<Category>());
    });

    test('update', () async {
      final box = categoryBox;
      Category cate = await box.add(category);
      cate.name = 'Alimento';
      cate = await box.update(cate);

      expect(cate, isA<Category>());
      expect(cate.name, 'Alimento');
    });

    test('del', () async {
      final box = categoryBox;
      Category cate = await box.add(category);

      await box.del(cate);

      List<Category> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });

    test('delAll', () async {
      final box = categoryBox;
      await box.add(category);

      await box.delAll();

      List<Category> cateList = await box.getAll();
      expect(cateList.isEmpty, isTrue);
    });
  });
}
