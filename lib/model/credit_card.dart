import 'package:brasil_fields/brasil_fields.dart';
import 'package:meus_gastos/model/user.dart';
import 'package:objectbox/objectbox.dart';
import 'interfaces/card.dart';

/// Classe que instancia um cartao de credito
@Entity()
class CreditCard implements Card {
  @Id()
  int id = 0;

  String name;
  int dayOfPayment;
  int dayGoodBuy;
  double limit = 0.0;
  String color;

  final user = ToOne<User>();

  CreditCard(
    this.name,
    this.dayOfPayment,
    this.dayGoodBuy, [
    this.color = '#000000',
    this.limit = 0.0,
  ]);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object? other) => other is CreditCard && other.name == name;

  @override
  String getValueMonetary() {
    return UtilBrasilFields.obterReal(limit);
  }
}
