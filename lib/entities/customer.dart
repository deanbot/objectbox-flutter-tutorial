import 'package:objectbox/objectbox.dart';

import 'shop_order.dart';

@Entity()
@Sync()
class Customer {
  int id;
  String name;

  @Backlink()
  final orders = ToMany<ShopOrder>();

  Customer({
    this.id = 0,
    required this.name,
  });
}
