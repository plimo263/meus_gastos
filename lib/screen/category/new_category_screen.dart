import 'package:flutter/material.dart';
import 'package:meus_gastos/screen/category/form_category.dart';

class NewCategoryScreen extends StatelessWidget {
  static const routeName = 'new_category';
  final String type;
  const NewCategoryScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormCategory(type: type);
  }
}
