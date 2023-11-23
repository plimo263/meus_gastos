import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/widgets/palette_color_select_widget.dart';
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
  static const colorSelect = 'ESCOLHA UMA COR';
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

  // void onColorSelect(String colorSelected) {
  //   setState(() {
  //     _color = colorSelected;
  //   });
  // }

  void onColorSelect() {
    Navigator.of(context)
        .push<String?>(MaterialPageRoute(
            builder: (context) => const PaletteColorSelectWidget()))
        .then((value) {
      if (value != null) {
        setState(() {
          _color = value;
        });
      }
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
      widget.category!.name = _nameField.text.trim();
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

  Color getColorSelected() {
    return _color != null ? HexColor(_color!) : Theme.of(context).primaryColor;
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
              spacing: 4.0,
              runSpacing: 4.0,
              children: _options.map((e) {
                return CircleAvatar(
                  maxRadius: 24,
                  backgroundColor:
                      _icon == e ? getColorSelected() : Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onIconSelect(e);
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
            ),
            const SizedBox(height: 16),
            const Text(
              _NewCategoryStr.titleColorSelect,
              style: titleStyle,
            ),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  side: BorderSide(
                    color: getColorSelected(),
                    width: 2,
                  ),
                ),
                onPressed: onColorSelect,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _NewCategoryStr.colorSelect,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: getColorSelected(),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.circle,
                      color: getColorSelected(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: onFormSave,
                child: const Text(
                  _NewCategoryStr.labelBtnSave,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
