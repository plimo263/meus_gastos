import 'package:objectbox/objectbox.dart';
import 'interfaces/card.dart';

/// Classe que instancia um cartao de credito
@Entity()
class CreditCard implements Card {
  @Id()
  int id = 0;

  @Unique()
  String name;
  int dayOfPayment;
  String color;

  CreditCard(this.name, this.dayOfPayment, [this.color = '#000000']);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object? other) => other is CreditCard && other.name == name;
}
