import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';
import 'package:meus_gastos/databases/object_db/objectbox.g.dart';

import 'package:meus_gastos/model/credit_card.dart';
import 'package:meus_gastos/themes/hexcolor.dart';
import 'package:meus_gastos/widgets/palette_color_select_widget.dart';
import 'package:provider/provider.dart';

typedef TypeValidator = String? Function(String? value);
typedef TypeSaved = void Function(String? value);

class _CreditCardFormStr {
  static const labelBtnSave = 'SALVAR';
  static const hintName = 'Nome do cartão';
  static const labelName = 'Nome do cartão';
  static const hintDayOfPayment = 'Dia Vencimento';
  static const labelDayOfPayment = 'Dia Vencimento';
  static const hintDayGoodBuy = 'Dia Fechamento';
  static const labelDayGoodBuy = 'Dia Fechamento';
  static const hintLimit = 'Limite';
  static const labelLimit = 'Limite';
  static const errorName = '* Nome do cartão requerido';
  static const errorDayOfPaymentNotNumber = '* Precisa ser um número';
  static const errorDayOfPayment = '* O dia de vencimento precisa se definido';
  static const errorDayGoodBuyNotNumber = '* Precisa ser um número';
  static const errorDayGoodBuy = '* O dia bom para compra precisa se definido';
  static const errorDuplicateCard = 'Já existe cartão de crédito com este nome';
  static const errorLimit = '* Defina o limite do cartão de crédito';
  static const colorSelect = 'ESCOLHA UMA COR';
  static const errorDayOutOfRange = '* Valor precisa ser entre 1 e 30';
}

class _CreditCardFields {
  String? name;
  int? dayOfPayment;
  int? dayGoodBuy;
  double? limit;
  String? color;

  String? validatorName(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return _CreditCardFormStr.errorName;
  }

  String? validatorDayOfPayment(String? value) {
    if (value != null && value.isNotEmpty) {
      int? valueDayOfPayment = int.tryParse(value);
      if (valueDayOfPayment != null) {
        if (valueDayOfPayment >= 1 && valueDayOfPayment <= 30) {
          return null;
        } else {
          return _CreditCardFormStr.errorDayOutOfRange;
        }
      } else {
        return _CreditCardFormStr.errorDayOfPaymentNotNumber;
      }
    }
    return _CreditCardFormStr.errorDayOfPayment;
  }

  String? validatorDayGoodBuy(String? value) {
    if (value != null && value.isNotEmpty) {
      int? valueDayGoodBuy = int.tryParse(value);
      if (valueDayGoodBuy != null) {
        if (valueDayGoodBuy >= 1 && valueDayGoodBuy <= 30) {
          return null;
        } else {
          return _CreditCardFormStr.errorDayOutOfRange;
        }
      } else {
        return _CreditCardFormStr.errorDayGoodBuyNotNumber;
      }
    }
    return _CreditCardFormStr.errorDayGoodBuy;
  }

  String? validatorLimit(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return _CreditCardFormStr.errorLimit;
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
    Key? key,
    this.creditCard,
  }) : super(key: key);

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

      final providerRef = Provider.of<CreditCardProviderController>(
        context,
        listen: false,
      );
      if (widget.creditCard != null) {
        widget.creditCard!.color = _color;
        widget.creditCard!.name = _creditCardFields.name!;
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
          _creditCardFields.name!,
          _creditCardFields.dayOfPayment!,
          _creditCardFields.dayGoodBuy!,
          _color,
          _creditCardFields.limit!,
        );
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          err.toString(),
        ),
      ),
    );
  }

  void onUniqueError(err) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          _CreditCardFormStr.errorDuplicateCard,
        ),
      ),
    );
  }

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

  Color getColorSelected() {
    return HexColor(_color);
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      {
        'index': 0,
        'initialValue': _creditCardFields.name,
        'hint': _CreditCardFormStr.hintName,
        'text': _CreditCardFormStr.labelName,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.name,
        'validator': _creditCardFields.validatorName,
        'save': _creditCardFields.saveName,
      },
      {
        'index': 1,
        'initialValue': _creditCardFields.dayOfPayment,
        'hint': _CreditCardFormStr.hintDayOfPayment,
        'text': _CreditCardFormStr.labelDayOfPayment,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.number,
        'validator': _creditCardFields.validatorDayOfPayment,
        'save': _creditCardFields.saveDayOfPayment,
      },
      {
        'index': 2,
        'initialValue': _creditCardFields.dayGoodBuy,
        'hint': _CreditCardFormStr.hintDayGoodBuy,
        'text': _CreditCardFormStr.labelDayGoodBuy,
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
        'hint': _CreditCardFormStr.hintLimit,
        'text': _CreditCardFormStr.labelLimit,
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
          }).toList(),
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
                      _CreditCardFormStr.colorSelect,
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
            child: ElevatedButton.icon(
              onPressed: _onSave,
              icon: const Icon(Icons.save),
              label: const Text(
                _CreditCardFormStr.labelBtnSave,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
