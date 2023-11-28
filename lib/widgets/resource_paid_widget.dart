import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/interfaces/resource_paid.dart';
import 'package:meus_gastos/model/speding_money.dart';
import 'package:meus_gastos/themes/hexcolor.dart';

class _ResourcePaidValue {
  Color color;
  String title;
  String nameRegister;
  String value;
  int icon;
  String time;

  _ResourcePaidValue(
    this.color,
    this.title,
    this.nameRegister,
    this.value,
    this.icon,
    this.time,
  );
}

class ResourcePaidWidget extends StatelessWidget {
  final ResourcePaid resourcePaid;
  final void Function<T>(T value) onTap;
  const ResourcePaidWidget({
    super.key,
    required this.resourcePaid,
    required this.onTap,
  });

  _ResourcePaidValue getResourceRunTime() {
    _ResourcePaidValue resource;

    if (resourcePaid is FinancialIncome) {
      FinancialIncome item = resourcePaid as FinancialIncome;
      resource = _ResourcePaidValue(
        HexColor(item.category.target!.color),
        item.category.target!.name,
        item.name,
        '+${item.getValueMonetary()}',
        item.category.target!.icon,
        item.getTime(),
      );
    } else {
      SpedingMoney item = resourcePaid as SpedingMoney;
      resource = _ResourcePaidValue(
        HexColor(item.category.target!.color),
        item.category.target!.name,
        item.name,
        '-${item.getValueMonetary()}',
        item.category.target!.icon,
        item.getTime(),
      );
    }

    return resource;
  }

  TextStyle getFormatTextMoney() {
    final textTheme = GoogleFonts.novaScript();
    if (resourcePaid is FinancialIncome) {
      return textTheme.copyWith(
        color: Colors.green.shade800,
        fontWeight: FontWeight.w700,
      );
    }

    return textTheme.copyWith(
      color: Colors.red.shade900,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  Widget build(BuildContext context) {
    final resource = getResourceRunTime();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: () => onTap(resourcePaid),
        leading: CircleAvatar(
          backgroundColor: resource.color,
          child: Icon(
            IconData(resource.icon, fontFamily: 'MaterialIcons'),
            color: Colors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(resource.title),
            AutoSizeText(resource.value, style: getFormatTextMoney()),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(resource.nameRegister),
            Text(resource.time),
          ],
        ),
      ),
    );
  }
}
