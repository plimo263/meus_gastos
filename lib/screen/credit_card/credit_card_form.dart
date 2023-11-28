import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/controller/provider/user_provider_controller.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';
import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';
import 'package:meus_gastos/widgets/palette_color_select_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/colors_selected_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef TypeValidator = String? Function(String? value);
typedef TypeSaved = void Function(String? value);

class _CreditCardFields {
  String? name;
  int? dayOfPayment;
  int? dayGoodBuy;
  double? limit;
  String? color;

  BuildContext? context;

  String? validatorName(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return AppLocalizations.of(context!)!.creditCardFormErrorName;
  }

  String? validatorDayOfPayment(String? value) {
    if (value != null && value.isNotEmpty) {
      int? valueDayOfPayment = int.tryParse(value);
      if (valueDayOfPayment != null) {
        if (valueDayOfPayment >= 1 && valueDayOfPayment <= 30) {
          return null;
        } else {
          return AppLocalizations.of(context!)!
              .creditCardFormErrorDayOutOfRange;
        }
      } else {
        return AppLocalizations.of(context!)!
            .creditCardFormErrorDayOfPaymentNotNumber;
      }
    }
    return AppLocalizations.of(context!)!.creditCardFormErrorDayOfPayment;
  }

  String? validatorDayGoodBuy(String? value) {
    if (value != null && value.isNotEmpty) {
      int? valueDayGoodBuy = int.tryParse(value);
      if (valueDayGoodBuy != null) {
        if (valueDayGoodBuy >= 1 && valueDayGoodBuy <= 30) {
          return null;
        } else {
          return AppLocalizations.of(context!)!
              .creditCardFormErrorDayOutOfRange;
        }
      } else {
        return AppLocalizations.of(context!)!
            .creditCardFormErrorDayGoodBuyNotNumber;
      }
    }
    return AppLocalizations.of(context!)!.creditCardFormErrorDayGoodBuy;
  }

  String? validatorLimit(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return AppLocalizations.of(context!)!.creditCardFormErrorLimit;
  }

  void saveName(String? value) {
    if (value != null) {
      name = value;
    }
  }

  void saveDayOfPayment(String? value) {
    if (value != null) {
      dayOfPayment = int.parse(value);
    }
  }

  void saveDayGoodBuy(String? value) {
    if (value != null) {
      dayGoodBuy = int.parse(value);
    }
  }

  void saveLimit(String? value) {
    if (value != null) {
      limit = UtilBrasilFields.converterMoedaParaDouble(value);
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dayOfPayment': dayOfPayment,
      'dayGoodBuy': dayGoodBuy,
      'limit': limit,
      'color': color,
    };
  }
}

class CreditCardForm extends StatefulWidget {
  final CreditCard? creditCard;
  const CreditCardForm({
    super.key,
    this.creditCard,
  });

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _creditCardFields = _CreditCardFields();
  String _color = '#000000';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //
    _creditCardFields.context = context;

    //
    if (widget.creditCard != null) {
      _color = widget.creditCard!.color;
      _creditCardFields.dayOfPayment = widget.creditCard!.dayOfPayment;
      _creditCardFields.dayGoodBuy = widget.creditCard!.dayGoodBuy;
      _creditCardFields.name = widget.creditCard!.name;
      _creditCardFields.limit = widget.creditCard!.limit;
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Verificar se o dia bom para compra e menor que o dia do fechamento
      final dayOfPayment = _creditCardFields.dayOfPayment!;
      final dayGoodBuy = _creditCardFields.dayGoodBuy!;

      if (dayGoodBuy > dayOfPayment) {
        AppSnackBar().snack(
          AppLocalizations.of(context)!
              .creditCardFormErrorDayGoodBuyGreatherDayPayment,
        );
        return;
      }

      final user = Provider.of<UserProviderController>(context, listen: false)
          .getUser() as User;

      final providerRef = Provider.of<CreditCardProviderController>(
        context,
        listen: false,
      );
      if (widget.creditCard != null) {
        widget.creditCard!.color = _color;
        widget.creditCard!.name = _creditCardFields.name!.trim();
        widget.creditCard!.dayOfPayment = _creditCardFields.dayOfPayment!;
        widget.creditCard!.dayGoodBuy = _creditCardFields.dayGoodBuy!;
        widget.creditCard!.limit = _creditCardFields.limit!;
        providerRef
            .update(widget.creditCard!)
            .then(onSuccess)
            .catchError(onUniqueError,
                test: (e) => e is UniqueViolationException)
            .catchError(onError, test: (e) => e is Exception);
      } else {
        final newCreditCard = CreditCard(
          _creditCardFields.name!.trim(),
          _creditCardFields.dayOfPayment!,
          _creditCardFields.dayGoodBuy!,
          _color,
          _creditCardFields.limit!,
        );
        newCreditCard.user.target = user;
        providerRef
            .add(newCreditCard)
            .then(onSuccess)
            .catchError(onUniqueError,
                test: (e) => e is UniqueViolationException)
            .catchError(onError, test: (e) => e is Exception);
      }

      providerRef;
    }
  }

  void onSuccess(dynamic _) {
    Navigator.of(context).pop();
  }

  void onError(err) {
    AppSnackBar().snack(err.toString());
  }

  void onUniqueError(err) {
    AppSnackBar().snack(
      AppLocalizations.of(context)!.creditCardFormErrorDuplicateCard,
    );
  }

  void onPaletteColorSelected() {
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

  void onColorSelected(String color) {
    _color = color;
    setState(() {});
  }

  Color getColorSelected() {
    return HexColor(_color);
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      {
        'index': 0,
        'initialValue': _creditCardFields.name,
        'hint': AppLocalizations.of(context)!.creditCardFormHintName,
        'text': AppLocalizations.of(context)!.creditCardFormLabelName,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.name,
        'validator': _creditCardFields.validatorName,
        'save': _creditCardFields.saveName,
      },
      {
        'index': 1,
        'initialValue': _creditCardFields.dayOfPayment,
        'hint': AppLocalizations.of(context)!.creditCardFormHintDayOfPayment,
        'text': AppLocalizations.of(context)!.creditCardFormLabelDayOfPayment,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.number,
        'validator': _creditCardFields.validatorDayOfPayment,
        'save': _creditCardFields.saveDayOfPayment,
      },
      {
        'index': 2,
        'initialValue': _creditCardFields.dayGoodBuy,
        'hint': AppLocalizations.of(context)!.creditCardFormHintDayGoodBuy,
        'text': AppLocalizations.of(context)!.creditCardFormLabelDayGoodBuy,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.number,
        'validator': _creditCardFields.validatorDayGoodBuy,
        'save': _creditCardFields.saveDayGoodBuy,
      },
      {
        'index': 3,
        'initialValue': _creditCardFields.limit != null
            ? UtilBrasilFields.obterReal(_creditCardFields.limit!)
            : null,
        'hint': AppLocalizations.of(context)!.creditCardFormHintLimit,
        'text': AppLocalizations.of(context)!.creditCardFormLabelLimit,
        'formatField': <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          CentavosInputFormatter(moeda: true),
        ],
        'inputType': TextInputType.number,
        'validator': _creditCardFields.validatorLimit,
        'save': _creditCardFields.saveLimit,
      },
    ];

    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...fields.map<Widget>((field) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                initialValue: field['initialValue']?.toString(),
                autofocus: (field['index'] as int) == 0,
                validator: field['validator'] as TypeValidator,
                onSaved: field['save'] as TypeSaved,
                keyboardType: field['inputType'] as TextInputType,
                inputFormatters:
                    field['formatField'] as List<TextInputFormatter>,
                decoration: InputDecoration(
                  hintText: field['hint'] as String,
                  labelText: field['text'] as String,
                  filled: true,
                ),
              ),
            );
          }),
          ColorsSelectedWidget(
            colorSelected: _color,
            onColorSelect: onColorSelected,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton.icon(
              onPressed: _onSave,
              icon: const Icon(Icons.save),
              label: Text(
                AppLocalizations.of(context)!.creditCardFormLabelBtnSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
