import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/screen/category/form_category.dart';

class UpdateCategoryScreen extends StatelessWidget {
  static const routeName = 'update_category';
  final Category category;
  final String type;
  const UpdateCategoryScreen({
    Key? key,
    required this.category,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormCategory(
      type: type,
      category: category,
    );
  }
}
