import 'package:objectbox/objectbox.dart';

import 'shop_order_entity.dart';

@Entity()
// @Sync()
class CustomerEntity {
  CustomerEntity({
    required this.id,
    required this.name,
  });

  @Id()
  int id;
  String name;

  @Backlink()
  final orders = ToMany<ShopOrderEntity>();
}
