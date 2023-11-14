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

  CreditCard(this.name, this.dayOfPayment);
}
