import 'package:flutter/material.dart';
import 'package:meus_gastos/constants/icons_default.dart';
import 'package:meus_gastos/widgets/palette_icons_select_widget.dart';

class IconsSelectedWidget extends StatefulWidget {
  final void Function(int icon) onIconSelected;
  final Color Function() getColorSelected;
  final int? iconSelected;
  const IconsSelectedWidget({
    Key? key,
    required this.iconSelected,
    required this.onIconSelected,
    required this.getColorSelected,
  }) : super(key: key);

  @override
  State<IconsSelectedWidget> createState() => _IconsSelectedWidgetState();
}

class _IconsSelectedWidgetState extends State<IconsSelectedWidget> {
  int? _icon;

  @override
  void initState() {
    super.initState();
    _icon = widget.iconSelected;
  }

//
  /// Recupera a lista de icones disponiveis na tela inicial
  List<int> getOptionsIcons() {
    if (_icon != null) {
      if (iconsDefault.contains(_icon)) {
        return iconsDefault;
      } else {
        iconsDefault.add(_icon!);
        return iconsDefault;
      }
    }
    return iconsDefault;
  }

  void onIconPaletteSelected() {
    Navigator.of(context)
        .push<int?>(MaterialPageRoute(
            builder: (context) => const PaletteIconsSelectWidget()))
        .then((value) {
      if (value != null) {
        setState(() {
          _icon = value;
        });
      }
    });
  }

  void onIconSelected(int icon) {
    widget.onIconSelected(icon);
    _icon = icon;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 20);
    final List<int> optionsIcons = getOptionsIcons();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Escolha um ícone',
          style: titleStyle,
        ),
        Wrap(spacing: 4.0, runSpacing: 4.0, children: [
          ...optionsIcons.map((e) {
            return CircleAvatar(
              maxRadius: 24,
              backgroundColor:
                  _icon == e ? widget.getColorSelected() : Colors.transparent,
              child: InkWell(
                onTap: () {
                  onIconSelected(e);
                },
                child: Icon(
                  IconData(
                    e,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: _icon == e ? Colors.white : Colors.black54,
                ),
              ),
            );
          }).toList(),
          Tooltip(
            message: 'Mais icones',
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: onIconPaletteSelected,
              child: Icon(
                Icons.more,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
