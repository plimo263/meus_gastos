import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  String getType() {
    if (category.type == 'income') {
      return 'Receita';
    }
    return 'Despesa';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: HexColor(category.color),
          child: Icon(
            IconData(category.icon, fontFamily: 'MaterialIcons'),
            color: Colors.white,
          ),
        ),
        title: Text(category.name),
        subtitle: Text(getType()),
      ),
    );
  }
}
