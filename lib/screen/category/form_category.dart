import 'package:flutter/material.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/widgets/colors_selected_widget.dart';
import 'package:meus_gastos/widgets/icons_selected_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormCategory extends StatefulWidget {
  final String type;
  final Category? category;

  const FormCategory({
    super.key,
    required this.type,
    this.category,
  });

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
    final refStr = AppLocalizations.of(context);
    if (widget.type == 'income') {
      return refStr!.formCategoryNewIncome;
    }
    return refStr!.formCategoryNewSpeding;
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
    final refStr = AppLocalizations.of(context);

    if (_nameField.text.isEmpty || _nameField.text.length < 3) {
      setState(() {
        _errorName = refStr!.formCategoryErrorName;
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
    final refStr = AppLocalizations.of(context);
    if (_icon == null) {
      AppSnackBar().snack(
        refStr!.formCategoryErrorIcon,
      );
      return false;
    }
    return true;
  }

  bool isColorSelect() {
    final refStr = AppLocalizations.of(context);
    if (_color == null) {
      AppSnackBar().snack(
        refStr!.formCategoryErrorColor,
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
    final refStr = AppLocalizations.of(context);

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
                hintText: refStr!.formCategoryHintName,
                labelText: refStr.formCategoryLabelName,
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
                child: Text(
                  refStr.formCategoryLabelBtnSave,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
