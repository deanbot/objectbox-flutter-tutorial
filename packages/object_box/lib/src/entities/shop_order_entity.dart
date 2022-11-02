import 'package:objectbox/objectbox.dart';

import 'customer_entity.dart';

@Entity()
// @Sync()
class ShopOrderEntity {
  ShopOrderEntity({
    required this.id,
    required this.price,
  });

  @Id()
  int id;
  double price;

  final customer = ToOne<CustomerEntity>();
}
