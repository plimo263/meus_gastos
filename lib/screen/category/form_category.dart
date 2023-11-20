import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/widgets/option_mark_widget.dart';
import 'package:provider/provider.dart';

final _options = [
  Icons.local_gas_station.codePoint,
  Icons.fastfood.codePoint,
  Icons.local_grocery_store.codePoint,
  Icons.sports_kabaddi.codePoint,
  Icons.redeem.codePoint,
  Icons.home.codePoint,
  Icons.wb_incandescent.codePoint,
  Icons.water_drop.codePoint,
  Icons.credit_card.codePoint,
  Icons.build.codePoint,
  Icons.pets.codePoint,
  Icons.health_and_safety.codePoint,
  Icons.sports_motorsports.codePoint,
  Icons.sports_soccer.codePoint,
  Icons.flight_takeoff.codePoint,
  Icons.school.codePoint,
  Icons.account_balance_wallet.codePoint,
];

final _colors = [
  '#ffd54f',
  '#ffca28',
  '#ffc107',
  '#ffb300',
  '#90A4AE',
  '#78909C',
  '#607D8B',
  '#546E7A',
  '#64B5F6',
  '#42A5F5',
  '#2196F3',
  '#1E88E5',
  '#A1887F',
  '#8D6E63',
  '#795548',
  '#4DD0E1',
  '#26C6DA',
  '#00BCD4',
  '#00ACC1',
  '#FF8A65',
  '#FF7043',
  '#FF5722',
  '#F4511E',
  '#9575CD',
  '#7E57C2',
  '#673AB7',
  '#5E35B1',
  '#81C784',
  '#66BB6A',
  '#4CAF50',
  '#43A047',
  '#E0E0E0',
  '#BDBDBD',
  '#9E9E9E',
  '#757575',
  '#7986CB',
  '#5C6BC0',
  '#3F51B5',
  '#3949AB',
  '#4FC3F7',
  '#29B6F6',
  '#03A9F4',
  '#039BE5',
  '#F06292',
  '#EC407A',
  '#E91E63',
  '#D81B60',
  '#BA68C8',
  '#AB47BC',
  '#9C27B0',
  '#8E24AA',
  '#E57373',
  '#F44336',
  '#E53935',
  '#EF5350',
];

/// Campos do formulario para nova categoria.
class _NewCategoryStr {
  static const newIncome = 'Nova Receita';
  static const newSpeding = 'Nova Despesa';
  static const labelName = 'Nome da Categoria';
  static const hintName = 'Nome da Categoria';
  static const titleIconSelect = 'Icone da categoria';
  static const titleColorSelect = 'Cor da categoria';
  static const labelBtnSave = 'CRIAR CATEGORIA';
  static const errorName = '* Mínimo de 2 caracteres';
  static const errorIcon = '* Escolha o icone representante';
  static const errorColor = '* Escolha uma das cores para o icone';
}

class FormCategory extends StatefulWidget {
  final String type;
  final Category? category;

  const FormCategory({
    Key? key,
    required this.type,
    this.category,
  }) : super(key: key);

  @override
  State<FormCategory> createState() => _FormCategoryState();
}

class _FormCategoryState extends State<FormCategory> {
  final _nameField = TextEditingController();
  String? _errorName;
  int? _icon;
  String? _color;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameField.text = widget.category!.name;
      _icon = widget.category!.icon;
      _color = widget.category!.color;
    }
  }

  String getType() {
    if (widget.type == 'income') {
      return _NewCategoryStr.newIncome;
    }
    return _NewCategoryStr.newSpeding;
  }

  void onIconSelect(int iconSelected) {
    setState(() {
      _icon = iconSelected;
    });
  }

  void onColorSelect(String colorSelected) {
    setState(() {
      _color = colorSelected;
    });
  }

  bool isNameInform() {
    if (_nameField.text.isEmpty || _nameField.text.length < 3) {
      setState(() {
        _errorName = _NewCategoryStr.errorName;
      });
      return false;
    } else {
      setState(() {
        _errorName = null;
      });
      return true;
    }
  }

  bool isIconSelect() {
    if (_icon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            _NewCategoryStr.errorIcon,
          ),
        ),
      );
      return false;
    }
    return true;
  }

  bool isColorSelect() {
    if (_color == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            _NewCategoryStr.errorColor,
          ),
        ),
      );
      return false;
    }
    return true;
  }

  void onFormSave() {
    if (!isNameInform()) return;

    if (!isIconSelect()) return;

    if (!isColorSelect()) return;

    final providerRef = Provider.of<CategoryProviderController>(
      context,
      listen: false,
    );

    if (widget.category != null) {
      widget.category!.name = _nameField.text;
      widget.category!.icon = _icon!;
      widget.category!.color = _color!;
      providerRef.update(widget.category!).then(onSuccess).catchError(onError);
    } else {
      // Estao validados criando nova categoria
      final newCategory = Category(
        name: _nameField.text,
        icon: _icon!,
        type: widget.type,
        color: _color!,
      );
      providerRef.add(newCategory).then(onSuccess).catchError(onError);
    }
  }

  void onSuccess(_) {
    Navigator.of(context).pop();
  }

  void onError(err) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          err.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text(getType()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              controller: _nameField,
              decoration: InputDecoration(
                filled: true,
                hintText: _NewCategoryStr.hintName,
                labelText: _NewCategoryStr.labelName,
                errorText: _errorName,
              ),
            ),
            const SizedBox(height: 16),
            const Text(_NewCategoryStr.titleIconSelect, style: titleStyle),
            Wrap(
              children: _options.map((e) {
                return OptionMarkWidget(
                  isMark: _icon == e,
                  toBackCheck: true,
                  widgetCheck: Container(
                    color: _color != null
                        ? HexColor(_color!)
                        : Theme.of(context).primaryColor,
                  ),
                  child: Card(
                    elevation: 3,
                    child: Material(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          onIconSelect(e);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            IconData(
                              e,
                              fontFamily: 'MaterialIcons',
                            ),
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              _NewCategoryStr.titleColorSelect,
              style: titleStyle,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colors.map((e) {
                return OptionMarkWidget(
                  isMark: e == _color,
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                        onTap: () {
                          onColorSelect(e);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 36,
                          height: 36,
                          color: HexColor(e),
                        )),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: onFormSave,
                child: const Text(_NewCategoryStr.labelBtnSave),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
