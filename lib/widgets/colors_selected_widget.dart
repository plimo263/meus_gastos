import 'package:flutter/material.dart';
import 'package:meus_gastos/widgets/palette_color_select_widget.dart';

import '../constants/colors_default.dart';
import '../themes/hexcolor.dart';

class ColorsSelectedWidget extends StatefulWidget {
  final void Function(String color) onColorSelect;
  final String? colorSelected;
  const ColorsSelectedWidget({
    Key? key,
    required this.colorSelected,
    required this.onColorSelect,
  }) : super(key: key);

  @override
  State<ColorsSelectedWidget> createState() => _ColorsSelectedWidgetState();
}

class _ColorsSelectedWidgetState extends State<ColorsSelectedWidget> {
  String? _color;

  @override
  void initState() {
    super.initState();
    _color = widget.colorSelected;
  }

//
  List<String> getOptionsColors() {
    if (_color != null) {
      if (colorsDefault.contains(_color)) {
        return colorsDefault;
      } else {
        colorsDefault.add(_color!);
        return colorsDefault;
      }
    }
    return colorsDefault;
  }

  void onColorPaletteSelected() {
    Navigator.of(context)
        .push<String?>(MaterialPageRoute(
            builder: (context) => const PaletteColorSelectWidget()))
        .then((value) {
      if (value != null) {
        setState(() {
          _color = value;
        });
        widget.onColorSelect(value);
      }
    });
  }

  void onColorSelected(String color) {
    widget.onColorSelect(color);
    _color = color;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 20);
    final List<String> optionsColors = getOptionsColors();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Selecione uma cor',
            style: titleStyle,
          ),
        ),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            ...optionsColors.map((e) {
              var childrens = <Widget>[
                Icon(
                  Icons.circle,
                  color: HexColor(e),
                  size: 48,
                ),
              ];
              if (e == _color) {
                childrens.add(const Icon(
                  Icons.radio_button_unchecked,
                  size: 48,
                ));
                childrens[0] = Positioned(
                  left: 6,
                  top: 6,
                  child: Icon(
                    Icons.circle,
                    color: HexColor(e),
                    size: 36,
                  ),
                );
              }
              return GestureDetector(
                onTap: () => onColorSelected(e),
                child: Stack(
                  children: childrens,
                ),
              );
            }).toList(),
            Tooltip(
              message: 'Mais cores',
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: onColorPaletteSelected,
                child: Icon(
                  Icons.more,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
