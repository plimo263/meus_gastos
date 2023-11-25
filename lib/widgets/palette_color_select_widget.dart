import 'package:flutter/material.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/widgets/option_mark_widget.dart';

final colorsMap = {
  "Page 1": {
    "Amber": {
      100: '#ffecb3',
      200: '#ffe082',
      300: '#ffd54f',
      400: '#ffca28',
      500: '#ffc107',
      600: '#ffb300',
      700: '#ffa000',
      800: '#ff8f00',
      900: '#ff6f00',
    },
    "Blue Grey": {
      100: '#CFD8DC',
      200: '#B0BEC5',
      300: '#90A4AE',
      400: '#78909C',
      500: '#607D8B',
      600: '#546E7A',
      700: '#455A64',
      800: '#37474F',
      900: '#263238',
    },
    "Blue": {
      100: '#BBDEFB',
      200: '#90CAF9',
      300: '#64B5F6',
      400: '#42A5F5',
      500: '#2196F3',
      600: '#1E88E5',
      700: '#1976D2',
      800: '#1565C0',
      900: '#0D47A1',
    },
    "Light Blue": {
      100: '#B3E5FC',
      200: '#81D4FA',
      300: '#4FC3F7',
      400: '#29B6F6',
      500: '#03A9F4',
      600: '#039BE5',
      700: '#0288D1',
      800: '#0277BD',
      900: '#01579B',
    },
    "Brown": {
      100: '#D7CCC8',
      200: '#BCAAA4',
      300: '#A1887F',
      400: '#8D6E63',
      500: '#795548',
      600: '#6D4C41',
      700: '#5D4037',
      800: '#4E342E',
      900: '#3E2723',
    },
    "Cyan": {
      100: '#B2EBF2',
      200: '#80DEEA',
      300: '#4DD0E1',
      400: '#26C6DA',
      500: '#00BCD4',
      600: '#00ACC1',
      700: '#0097A7',
      800: '#00838F',
      900: '#006064',
    },
    "Orange": {
      100: '#FFE0B2',
      200: '#FFCC80',
      300: '#FFB74D',
      400: '#FFA726',
      500: '#FF9800',
      600: '#FB8C00',
      700: '#F57C00',
      800: '#EF6C00',
      900: '#E65100',
    },
    "Deep Orange": {
      100: '#FFCCBC',
      200: '#FFAB91',
      300: '#FF8A65',
      400: '#FF7043',
      500: '#FF5722',
      600: '#F4511E',
      700: '#E64A19',
      800: '#D84315',
      900: '#BF360C',
    },
    "Purple": {
      100: '#E1BEE7',
      200: '#CE93D8',
      300: '#BA68C8',
      400: '#AB47BC',
      500: '#9C27B0',
      600: '#8E24AA',
      700: '#7B1FA2',
      800: '#6A1B9A',
      900: '#4A148C',
    },
    "Deep Purple": {
      100: '#D1C4E9',
      200: '#B39DDB',
      300: '#9575CD',
      400: '#7E57C2',
      500: '#673AB7',
      600: '#5E35B1',
      700: '#512DA8',
      800: '#4527A0',
      900: '#311B92',
    },
  },
  "Page 3": {
    "Green": {
      100: '#C8E6C9',
      200: '#A5D6A7',
      300: '#81C784',
      400: '#66BB6A',
      500: '#4CAF50',
      600: '#43A047',
      700: '#388E3C',
      800: '#2E7D32',
      900: '#1B5E20',
    },
    "Light Green": {
      100: '#DCEDC8',
      200: '#C5E1A5',
      300: '#AED581',
      400: '#9CCC65',
      500: '#8BC34A',
      600: '#7CB342',
      700: '#689F38',
      800: '#558B2F',
      900: '#33691E',
    },
    "Grey": {
      100: '#F5F5F5',
      200: '#EEEEEE',
      300: '#E0E0E0',
      400: '#BDBDBD',
      500: '#9E9E9E',
      600: '#757575',
      700: '#616161',
      800: '#424242',
      900: '#212121',
    },
    "Indigo": {
      100: '#C5CAE9',
      200: '#9FA8DA',
      300: '#7986CB',
      400: '#5C6BC0',
      500: '#3F51B5',
      600: '#3949AB',
      700: '#303F9F',
      800: '#283593',
      900: '#1A237E',
    },
    "Lime": {
      100: '#F0F4C3',
      200: '#E6EE9C',
      300: '#DCE775',
      400: '#D4E157',
      500: '#CDDC39',
      600: '#C0CA33',
      700: '#AFB42B',
      800: '#9E9D24',
      900: '#827717',
    },
    "Pink": {
      100: '#F8BBD0',
      200: '#F48FB1',
      300: '#F06292',
      400: '#EC407A',
      500: '#E91E63',
      600: '#D81B60',
      700: '#C2185B',
      800: '#AD1457',
      900: '#880E4F',
    },
    "Red": {
      100: '#FFCDD2',
      200: '#EF9A9A',
      300: '#E57373',
      400: '#EF5350',
      500: '#F44336',
      600: '#E53935',
      700: '#D32F2F',
      800: '#C62828',
      900: '#B71C1C',
    },
    "Teal": {
      100: '#B2DFDB',
      200: '#80CBC4',
      300: '#4DB6AC',
      400: '#26A69A',
      500: '#009688',
      600: '#00897B',
      700: '#00796B',
      800: '#00695C',
      900: '#004D40',
    },
    "Yellow": {
      100: '#FFF9C4',
      200: '#FFF59D',
      300: '#FFF176',
      400: '#FFEE58',
      500: '#FFEB3B',
      600: '#FDD835',
      700: '#FBC02D',
      800: '#F9A825',
      900: '#F57F17',
    },
  }
};

class PaletteColorSelectWidget extends StatefulWidget {
  const PaletteColorSelectWidget({Key? key}) : super(key: key);

  @override
  State<PaletteColorSelectWidget> createState() =>
      _PaletteColorSelectWidgetState();
}

class _PaletteColorSelectWidgetState extends State<PaletteColorSelectWidget>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  String? _colorSelected;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: colorsMap.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  void onTapColor(String colorSelected) {
    setState(() {
      _colorSelected = colorSelected;
    });
  }

  /// Retorna a cor escolhida pelo usuário
  void onSaveColor() {
    if (_colorSelected != null) {
      Navigator.of(context).pop(_colorSelected);
    } else {
      AppSnackBar().snack('Escolha uma cor');
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [];

    /// Separa as áreas em lista de widgets
    for (String keyPage in colorsMap.keys) {
      pages.add(_PaletteColorPage(
        colors: colorsMap[keyPage]!,
        colorSelection: _colorSelected,
        onTap: onTapColor,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paleta de cores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              controller: controller,
              children: pages,
            ),
            Positioned(
              bottom: 24,
              child: TabPageSelector(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _colorSelected != null
          ? FloatingActionButton(
              tooltip: 'Salvar a cor escolhida',
              onPressed: onSaveColor,
              child: const Icon(
                Icons.palette,
              ),
            )
          : null,
    );
  }
}

// Lista com a variacao de cores.
class _PaletteColorPage extends StatelessWidget {
  final Map<String, Map<int, String>> colors;
  final String? colorSelection;
  final void Function(String colorSelect) onTap;
  const _PaletteColorPage({
    Key? key,
    required this.colors,
    required this.onTap,
    required this.colorSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keysColors = colors.keys.toList();
    final widthLarge = MediaQuery.of(context).size.width / 9 - 8;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 72),
      itemCount: keysColors.length,
      itemBuilder: ((context, index) {
        final colorName = keysColors[index];
        final colorOptions = colors[colorName]!;
        final childrens = <Widget>[];
        //
        for (int key in colorOptions.keys) {
          childrens.add(OptionMarkWidget(
            isMark: colorOptions[key] == colorSelection,
            child: Material(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                  onTap: () {
                    onTap(colorOptions[key]!);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: widthLarge,
                    height: widthLarge,
                    color: HexColor(colorOptions[key]!),
                  )),
            ),
          ));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              colorName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              children: childrens,
            )
          ],
        );
      }),
    );
  }
}
