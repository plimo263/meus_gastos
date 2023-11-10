import 'package:meus_gastos/dao/base_dao.dart';

import '../model/category.dart';

/// Abstração para manutenção de categorias
/// Categorias são a forma de separar os recursos de entrada/saida do aplicativo
abstract class CategoryDAO extends BaseDao<Category> {}
