import 'package:objectbox/objectbox.dart';

import 'customer.dart';

@Entity()
@Sync()
class ShopOrder {
  int id;
  int price;

  final customer = ToOne<Customer>();

  ShopOrder({
    this.id = 0,
    required this.price,
  });
}
