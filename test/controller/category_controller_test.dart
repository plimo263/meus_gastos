import 'package:flutter_test/flutter_test.dart';
import 'package:meus_gastos/controller/category_controller.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/dao/dao_connector.dart';
import 'package:meus_gastos/dao/objectbox/category_box.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/repository/category_repository.dart';

void main() {
  late final CategoryController categoryController;

  setUpAll(() async {
    final connector = await initConnectors(directory: './objectbox_databases/');
    categoryController = CategoryProviderController(
      CategoryRepository(
        connector.category as CategoryBoxImpl,
      ),
      <Category>[],
    );
    // Limpando a casa
    categoryController.delAll(clearDB: true);
  });

  tearDownAll(() {
    categoryController.delAll(clearDB: true);
  });

  group('CategoryController', () {
    test('add', () async {
      final cate = Category(name: 'Alimentação', icon: 898878, type: 'income');
      await categoryController.add(cate);
    });

    test('update', () async {
      final cateList = categoryController.getAll();
      final cate = cateList[0];
      cate.name = 'Padaria';
      await categoryController.update(cate);
    });

    test('getAll', () {
      final cateList = categoryController.getAll();
      expect(cateList, isNotEmpty);
    });

    test('del', () {
      final cateList = categoryController.getAll();
      final cate = cateList[0];
      categoryController.del(cate);
    });

    test('delAll', () {
      categoryController.delAll();
      expect(categoryController.getAll(), isEmpty);
    });
  });
}
