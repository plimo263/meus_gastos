import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: HexColor(category.color),
        child: Icon(
          IconData(category.icon, fontFamily: 'MaterialIcons'),
        ),
      ),
      title: Text(category.name),
      subtitle: Text(category.type),
    );
  }
}
