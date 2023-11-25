import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/widgets/colors_selected_widget.dart';
import 'package:meus_gastos/widgets/icons_selected_widget.dart';
import 'package:provider/provider.dart';

/// Campos do formulario para nova categoria.
class _NewCategoryStr {
  static const newIncome = 'Nova Receita';
  static const newSpeding = 'Nova Despesa';
  static const labelName = 'Nome da Categoria';
  static const hintName = 'Nome da Categoria';
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

  void onColorSelect(String colorSelect) {
    setState(() {
      _color = colorSelect;
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
      AppSnackBar().snack(
        _NewCategoryStr.errorIcon,
      );
      return false;
    }
    return true;
  }

  bool isColorSelect() {
    if (_color == null) {
      AppSnackBar().snack(
        _NewCategoryStr.errorColor,
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

    final user =
        Provider.of<UserProviderController>(context, listen: false).getUser();

    if (widget.category != null) {
      widget.category!.name = _nameField.text.trim();
      widget.category!.icon = _icon!;
      widget.category!.color = _color!;
      providerRef.update(widget.category!).then(onSuccess).catchError(onError);
    } else {
      // Estao validados criando nova categoria
      final newCategory = Category(
        name: _nameField.text.trim(),
        icon: _icon!,
        type: widget.type,
        color: _color!,
      );
      newCategory.user.target = user!;
      providerRef.add(newCategory).then(onSuccess).catchError(onError);
    }
  }

  void onSuccess(_) {
    Navigator.of(context).pop();
  }

  void onError(err) {
    AppSnackBar().snack(err.toString());
  }

  Color getColorSelected() {
    return _color != null ? HexColor(_color!) : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
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
            IconsSelectedWidget(
              iconSelected: _icon,
              onIconSelected: onIconSelect,
              getColorSelected: getColorSelected,
            ),
            const SizedBox(height: 16),
            ColorsSelectedWidget(
              colorSelected: _color,
              onColorSelect: onColorSelect,
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
