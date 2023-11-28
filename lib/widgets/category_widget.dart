import 'package:flutter/material.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Category category;
  const CategoryWidget(
      {super.key, required this.category, required this.onTap});

  String getType() {
    if (category.type == 'income') {
      return 'Receita';
    }
    return 'Despesa';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: HexColor(category.color),
            child: Icon(
              IconData(category.icon, fontFamily: 'MaterialIcons'),
              color: Colors.white,
            ),
          ),
          title: Text(category.name),
          //subtitle: Text(getType()),
        ),
      ),
    );
  }
}
