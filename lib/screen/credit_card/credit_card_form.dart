import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meus_gastos/controller/provider/credit_card_provider_controller.dart';

import 'package:meus_gastos/model/credit_card.dart';
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
  static const errorLimitNotNumber = '* Precisa ser um número';
  static const errorLimit = '* Defina o limite do cartão de crédito';
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
        return null;
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
        return null;
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
  final _formKey = GlobalKey<FormState>();

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newCreditCard = CreditCard(
        _creditCardFields.name!,
        _creditCardFields.dayOfPayment!,
        _creditCardFields.dayGoodBuy!,
        '#000000',
        _creditCardFields.limit!,
      );

      Provider.of<CreditCardProviderController>(context, listen: false)
          .add(newCreditCard)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              err.toString(),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      {
        'hint': _CreditCardFormStr.hintName,
        'text': _CreditCardFormStr.labelName,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.name,
        'validator': _creditCardFields.validatorName,
        'save': _creditCardFields.saveName,
      },
      {
        'hint': _CreditCardFormStr.hintDayOfPayment,
        'text': _CreditCardFormStr.labelDayOfPayment,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.number,
        'validator': _creditCardFields.validatorDayOfPayment,
        'save': _creditCardFields.saveDayOfPayment,
      },
      {
        'hint': _CreditCardFormStr.hintDayGoodBuy,
        'text': _CreditCardFormStr.labelDayGoodBuy,
        'formatField': <TextInputFormatter>[],
        'inputType': TextInputType.number,
        'validator': _creditCardFields.validatorDayGoodBuy,
        'save': _creditCardFields.saveDayGoodBuy,
      },
      {
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
