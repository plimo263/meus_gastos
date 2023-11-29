import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/controller/provider/category_provider_controller.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/resource_paid_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/model/category.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/model/speding_money.dart';
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
typedef TypeCreditCardValidator = String? Function(CreditCard? value);
typedef TypeCreditCardSaved = void Function(CreditCard? value);

class _SpedingFields {
  String? name;
  String description = '';
  DateTime? dateRegister;
  double? price;
  Category? category;
  int quantityParcel = 0;
  CreditCard? creditCard;

  BuildContext? ctx;

  String? validatorName(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formSpendingErrorName;
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
    return AppLocalizations.of(ctx!)!.formSpendingErrorDescription;
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
    return AppLocalizations.of(ctx!)!.formSpendingErrorDateRegister;
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
    return AppLocalizations.of(ctx!)!.formSpendingErrorPrice;
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
    return AppLocalizations.of(ctx!)!.formSpendingErrorCategory;
  }

  void saveCategory(Category? categoryValue) {
    category = categoryValue;
  }

  String? validatorCreditCard(CreditCard? value) {
    if (value != null) {
      return null;
    }
    return AppLocalizations.of(ctx!)!.formSpendingErrorCreditCard;
  }

  void saveCreditCard(CreditCard? inCreditCard) {
    creditCard = inCreditCard;
  }

  String? validatorParcel(String? value) {
    if (value != null) {
      int? vl = int.tryParse(value);
      if (vl != null && vl > 0) {
        return null;
      }
    }
    return AppLocalizations.of(ctx!)!.formSpendingErrorNumberParcel;
  }

  void saveParcel(String? inNumber) {
    quantityParcel = int.tryParse(inNumber!) ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'price': price,
      'description': description,
      'name': name,
      'date_register': dateRegister,
      'quantityParcel': quantityParcel,
      'credit_card': creditCard,
    };
  }
}

class FormSpeding extends StatefulWidget {
  final SpedingMoney? speding;
  const FormSpeding({
    super.key,
    this.speding,
  });

  @override
  State<FormSpeding> createState() => _FormSpedingState();
}

class _FormSpedingState extends State<FormSpeding> {
  List<Category> _categories = [];
  List<CreditCard> _creditCards = [];
  bool isUsedCreditCard = false;
  final _formField = _SpedingFields();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _formField.ctx = context;

    if (widget.speding != null) {
      _formField.category = widget.speding!.category.target;
      _formField.name = widget.speding!.name;
      _formField.description = widget.speding!.description;
      _formField.price = widget.speding!.value;
      _formField.dateRegister = widget.speding!.dateRegister;
      _formField.creditCard = widget.speding!.creditCard.target;

      setState(() {});
    }
    // Recupera as categorias
    Future.microtask(() {
      final spedings = Provider.of<CategoryProviderController>(
        context,
        listen: false,
      ).getAll().where((element) => element.type == 'speding').toList();
      _categories = spedings;
      setState(() {});
    });
    // Recupera os cartoes de credito
    Future.microtask(() {
      final credits = Provider.of<CreditCardProviderController>(
        context,
        listen: false,
      ).getAll();
      _creditCards = credits;
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
          hintText: AppLocalizations.of(context)!.formSpendingHintName,
          labelText: AppLocalizations.of(context)!.formSpendingLabelName,
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
          hintText: AppLocalizations.of(context)!.formSpendingHintDateRegister,
          labelText:
              AppLocalizations.of(context)!.formSpendingLabelDateRegister,
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
          hintText: AppLocalizations.of(context)!.formSpendingHintPrice,
          labelText: AppLocalizations.of(context)!.formSpendingLabelPrice,
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
          hintText: AppLocalizations.of(context)!.formSpendingHintCategory,
          labelText: AppLocalizations.of(context)!.formSpendingLabelCategory,
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
          hintText: AppLocalizations.of(context)!.formSpendingHintDescription,
          labelText: AppLocalizations.of(context)!.formSpendingLabelDescription,
          filled: true,
        ),
      },
      {
        'index': '5',
        'initialValue': isUsedCreditCard,
        'title': Text(
          AppLocalizations.of(context)!.formSpendingLabelIsCreditCard,
        ),
        'decoration': const InputDecoration(
          filled: true,
        ),
      }
    ];
  }

  // A quantidade de parcelas do cartão de crédito
  List<Map<String, dynamic>> getNumberParcel() {
    return [
      {
        'index': '6',
        'initialValue': _formField.creditCard,
        'validator': _formField.validatorCreditCard,
        'onSaved': _formField.saveCreditCard,
        'keyBoardType': null,
        'inputFormatters': null,
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formSpendingHintCreditCard,
          labelText: AppLocalizations.of(context)!.formSpendingLabelCreditCard,
          filled: true,
        ),
      },
      {
        'index': '7',
        'initialValue': _formField.quantityParcel,
        'validator': _formField.validatorParcel,
        'onSaved': _formField.saveParcel,
        'keyBoardType': TextInputType.number,
        'inputFormatters': [
          FilteringTextInputFormatter.digitsOnly,
        ],
        'decoration': InputDecoration(
          hintText: AppLocalizations.of(context)!.formSpendingHintNumberParcel,
          labelText:
              AppLocalizations.of(context)!.formSpendingLabelNumberParcel,
          filled: true,
        ),
      }
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

      SpedingMoney? spedingRegister;
      // Atualizando o registro
      if (widget.speding != null) {
        widget.speding!.name = values['name'];
        widget.speding!.value = values['price'];
        widget.speding!.dateRegister = values['date_register'];
        widget.speding!.description = values['description'];
        widget.speding!.category.target = values['category'] as Category;

        spedingRegister = widget.speding as SpedingMoney;

        providerRef.update(spedingRegister).then((_) {
          Navigator.of(context).pop();
        }).catchError(onError);
      } else {
        // Criando um novo registro
        spedingRegister = SpedingMoney(
          name: values['name'],
          value: values['price'],
          dateRegister: values['date_register'] as DateTime,
          description: values['description'],
        );
        spedingRegister.category.target = values['category'] as Category;
        spedingRegister.user.target = user;
        // Veja se tem cartao de credito
        if (isUsedCreditCard) {
          // TODO Montar lógica para o parcelamento com o cartão de crédito
        }

        providerRef.add(spedingRegister).then((_) {
          Navigator.of(context).pop();
        }).catchError(onError);
      }
    }
    //
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
    if (isUsedCreditCard) {
      formFields.addAll(getNumberParcel());
    }

    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...formFields.map((e) {
            // Escolha de data/hora
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
              // Escolha de categorias
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
            } else if (e['index'] == '5') {
              // Define se vai utilizar o cartao de credito
              return FormBuilderSwitch(
                name: e['index'] as String,
                initialValue: e['initialValue'] as bool,
                title: e['title'] as Widget,
                decoration: e['decoration'] as InputDecoration,
                onChanged: (bool? useCard) {
                  if (useCard != null && useCard) {
                    if (_creditCards.isEmpty) {
                      AppSnackBar().snack(AppLocalizations.of(context)!
                          .formSpendingErrorNoCreditCard);
                      return;
                    }
                  }
                  setState(() {
                    isUsedCreditCard = useCard ?? false;
                  });
                },
              );
            } else if (e['index'] == '6') {
              // Escolha de cartao de credito
              final items = _creditCards
                  .map<DropdownMenuItem<CreditCard>>(
                    (e) => DropdownMenuItem<CreditCard>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList();

              return FormBuilderDropdown<CreditCard>(
                name: e['index'] as String,
                items: items,
                initialValue:
                    e.containsKey('initialValue') ? e['initialValue'] : null,
                validator: e['validator'] as TypeCreditCardValidator,
                onSaved: e['onSaved'] as TypeCreditCardSaved,
                decoration: e['decoration'] as InputDecoration,
                style: e.containsKey('style') ? e['style'] as TextStyle : null,
              );
            }

            // Os demais campos (nome, descricao, valor monetario, etc...)
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FormBuilderTextField(
                name: e['index'] as String,
                initialValue: e['initialValue'].toString(),
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
              child:
                  Text(AppLocalizations.of(context)!.formSpendingLabelBtnSave),
            ),
          )
        ],
      ),
    );
  }
}
