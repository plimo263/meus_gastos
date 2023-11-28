import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/financial_income.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef TypeValidator = String? Function(String? value);
typedef TypeSaved = void Function(String? value);
typedef TypeDateTimeValidator = String? Function(DateTime? value);
typedef TypeDateTimeSaved = void Function(DateTime? value);
typedef TypeCategoryValidator = String? Function(Category? value);
typedef TypeCategorySaved = void Function(Category? value);

class _IncomeFields {
  String? name;
  String description = '';
  DateTime? dateRegister;
  double? price;
  Category? category;

  BuildContext? ctx;

  String? validatorName(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formIncomeErrorName;
  }

  void saveName(String? value) {
    if (value != null) {
      name = value;
    }
  }

  String? validatorDescription(String? value) {
    if (value != null) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formIncomeErrorDescription;
  }

  void saveDescription(String? value) {
    if (value != null) {
      description = value;
    }
  }

  String? validatorDateRegister(DateTime? value) {
    if (value != null) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formIncomeErrorDateRegister;
  }

  void saveDateRegister(DateTime? value) {
    if (value != null) {
      dateRegister = value;
    }
  }

  String? validatorValueMoney(String? valueMoney) {
    if (valueMoney != null && valueMoney.isNotEmpty) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formIncomeErrorPrice;
  }

  void saveValueMoney(String? valueMoney) {
    if (valueMoney != null) {
      price = UtilBrasilFields.converterMoedaParaDouble(valueMoney);
    }
  }

  String? validatorCategory(Category? value) {
    if (value != null) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formIncomeErrorCategory;
  }

  void saveCategory(Category? categoryValue) {
    category = categoryValue;
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'price': price,
      'description': description,
      'name': name,
      'date_register': dateRegister,
    };
  }
}

class FormIncome extends StatefulWidget {
  final FinancialIncome? income;
  const FormIncome({
    super.key,
    this.income,
  });

  @override
  State<FormIncome> createState() => _FormIncomeState();
}

class _FormIncomeState extends State<FormIncome> {
  List<Category> _categories = [];
  final _formField = _IncomeFields();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _formField.ctx = context;

    if (widget.income != null) {
      _formField.category = widget.income!.category.target;
      _formField.name = widget.income!.name;
      _formField.description = widget.income!.description;
      _formField.price = widget.income!.value;
      _formField.dateRegister = widget.income!.dateRegister;
      setState(() {});
    }
    Future.microtask(() {
      final incomes = Provider.of<CategoryProviderController>(
        context,
        listen: false,
      ).getAll().where((element) => element.type == 'income').toList();
      _categories = incomes;
      setState(() {});
    });
  }

  DateTime getValueInitialDate() {
    DateTime valueDate = DateTime.now();
    if (_formField.dateRegister != null) {
      valueDate = _formField.dateRegister!;
    }
    return DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:00').format(valueDate));
  }

  /// Recupera os campos do formulário
  List<Map<String, dynamic>> getFields() {
    return [
      {
        'index': '0',
        'initialValue': _formField.name ?? '',
        'validator': _formField.validatorName,
        'onSaved': _formField.saveName,
        'keyBoardType': TextInputType.text,
        'inputFormatters': null,
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formIncomeHintName,
          labelText: AppLocalizations.of(context)!.formIncomeLabelName,
          filled: true,
        ),
      },
      {
        'index': '2',
        'initialValue': getValueInitialDate(),
        'firstDate': getPrimeiroDia(),
        'lastDate': getUltimoDia(),
        'validator': _formField.validatorDateRegister,
        'onSaved': _formField.saveDateRegister,
        'keyBoardType': TextInputType.text,
        'inputFormatters': null,
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formIncomeHintDateRegister,
          labelText: AppLocalizations.of(context)!.formIncomeLabelDateRegister,
          filled: true,
        ),
      },
      {
        'index': '3',
        'initialValue': UtilBrasilFields.obterReal(
          _formField.price != null ? _formField.price as double : 0.0,
        ),
        'validator': _formField.validatorValueMoney,
        'onSaved': _formField.saveValueMoney,
        'keyBoardType': TextInputType.number,
        'inputFormatters': [
          FilteringTextInputFormatter.digitsOnly,
          CentavosInputFormatter(moeda: true),
        ],
        'style': GoogleFonts.novaScript(
          fontSize: 24,
        ),
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formIncomeHintPrice,
          labelText: AppLocalizations.of(context)!.formIncomeLabelPrice,
          filled: true,
        ),
      },
      {
        'index': '4',
        'initialValue': _formField.category,
        'validator': _formField.validatorCategory,
        'onSaved': _formField.saveCategory,
        'keyBoardType': null,
        'inputFormatters': null,
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formIncomeHintCategory,
          labelText: AppLocalizations.of(context)!.formIncomeLabelCategory,
          filled: true,
        ),
      },
      {
        'index': '1',
        'initialValue': _formField.description,
        'validator': _formField.validatorDescription,
        'onSaved': _formField.saveDescription,
        'keyBoardType': TextInputType.multiline,
        'inputFormatters': null,
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formIncomeHintDescription,
          labelText: AppLocalizations.of(context)!.formIncomeLabelDescription,
          filled: true,
        ),
      },
    ];
  }

  //Função para salvar os dados
  void onSave() {
    final user = Provider.of<UserProviderController>(context, listen: false)
        .getUser() as User;
    //
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formField.toMap();
      //
      var providerRef =
          Provider.of<ResourcePaidProviderController>(context, listen: false);

      FinancialIncome? incomeRegister;
      // Atualiznado o registro
      if (widget.income != null) {
        widget.income!.name = values['name'];
        widget.income!.value = values['price'];
        widget.income!.dateRegister = values['date_register'];
        widget.income!.description = values['description'];
        widget.income!.category.target = values['category'] as Category;

        incomeRegister = widget.income as FinancialIncome;

        providerRef.update(incomeRegister).then((_) {
          Navigator.of(context).pop();
        }).catchError(onError);
      } else {
        // Criando um novo registro
        incomeRegister = FinancialIncome(
          name: values['name'],
          value: values['price'],
          dateRegister: values['date_register'] as DateTime,
          description: values['description'],
        );
        incomeRegister.category.target = values['category'] as Category;
        incomeRegister.user.target = user;

        providerRef.add(incomeRegister).then((_) {
          Navigator.of(context).pop();
        }).catchError(onError);
      }
      //
    }
  }

  //
  FutureOr<Null> onError(Object err) {
    AppSnackBar().snack(err.toString());
  }

  //
  DateTime getPrimeiroDia() {
    final hoje = DateTime.now();
    return DateTime(hoje.year, hoje.month, 1);
  }

  DateTime getUltimoDia() {
    final hoje = DateTime.now();
    return DateTime(hoje.year, hoje.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    final formFields = getFields();

    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...formFields.map((e) {
            if (e['index'] == '2') {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FormBuilderDateTimePicker(
                  locale: const Locale('pt', 'BR'),
                  name: e['index'] as String,
                  initialValue: e['initialValue'] as DateTime,
                  firstDate: e['firstDate'] as DateTime,
                  lastDate: e['lastDate'] as DateTime,
                  style:
                      e.containsKey('style') ? e['style'] as TextStyle : null,
                  validator: e['validator'] as TypeDateTimeValidator,
                  onSaved: e['onSaved'] as TypeDateTimeSaved,
                  keyboardType: e['keyBoardType'] as TextInputType,
                  inputFormatters: e['inputFormatters'] != null
                      ? e['inputFormatters'] as List<TextInputFormatter>
                      : null,
                  decoration: e['decoration'] as InputDecoration,
                ),
              );
            } else if (e['index'] == '4') {
              final items = _categories
                  .map<DropdownMenuItem<Category>>(
                    (e) => DropdownMenuItem<Category>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList();

              return FormBuilderDropdown<Category>(
                name: e['index'] as String,
                items: items,
                initialValue:
                    e.containsKey('initialValue') ? e['initialValue'] : null,
                validator: e['validator'] as TypeCategoryValidator,
                onSaved: e['onSaved'] as TypeCategorySaved,
                decoration: e['decoration'] as InputDecoration,
                style: e.containsKey('style') ? e['style'] as TextStyle : null,
              );
            }
            //
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FormBuilderTextField(
                name: e['index'] as String,
                initialValue: e['initialValue'] as String,
                validator: e['validator'] as TypeValidator,
                onSaved: e['onSaved'] as TypeSaved,
                keyboardType: e['keyBoardType'] as TextInputType,
                inputFormatters: e['inputFormatters'] != null
                    ? e['inputFormatters'] as List<TextInputFormatter>
                    : null,
                maxLines: e['index'] == '1' ? null : 1,
                minLines: e['index'] == '1' ? 3 : null,
                decoration: e['decoration'] as InputDecoration,
                style: e.containsKey('style') ? e['style'] as TextStyle : null,
              ),
            );
          }),
          const SizedBox(height: 8),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: onSave,
              child: Text(AppLocalizations.of(context)!.formIncomeLabelBtnSave),
            ),
          )
        ],
      ),
    );
  }
}
