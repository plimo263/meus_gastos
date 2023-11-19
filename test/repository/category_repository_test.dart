import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/repository/category_repository.dart';

final category = Category(name: 'Alimentação', icon: 898878, type: 'income');

void main() {
  late final CategoryRepository categoryRepository;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    categoryRepository =
        CategoryRepository(connector.category as CategoryBoxImpl);
    // Limpando a casa
    categoryRepository.delAll();
  });

  tearDownAll(() {
    categoryRepository.delAll();
  });
  group('CategoryRepository', () {
    test('add', () async {
      final cate = await categoryRepository.add(category);
      expect(cate, isA<Category>());
    });

    test('getAll', () async {
      final categoryList = await categoryRepository.getAll();
      expect(categoryList.isEmpty, isFalse);
    });

    test('update', () async {
      category.name = 'Novo nome';
      final cate = await categoryRepository.update(category);
      expect(cate, isA<Category>());
    });

    test('delAll', () async {
      await categoryRepository.delAll();
      final cateList = await categoryRepository.getAll();
      expect(cateList.isEmpty, isTrue);
    });
  });
}
