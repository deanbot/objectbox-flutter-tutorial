import 'package:object_box/object_box.dart';
import 'package:shop_core/shop_core.dart';

extension ShopOrderExtension on ShopOrder {
  ShopOrderEntity get toEntity =>
      ShopOrderEntity(id: int.parse(id), price: price)
        ..customer.target = customer.toEntity;
}

extension ShopOrderEntityExtension on ShopOrderEntity {
  ShopOrder get toDomain => ShopOrder(
      id: id.toString(), price: price, customer: customer.target!.toDomain);
}

extension CustomerExtension on Customer {
  CustomerEntity get toEntity => CustomerEntity(id: int.parse(id), name: name);
}

extension CustomerEntityExtension on CustomerEntity {
  Customer get toDomain => Customer(id: id.toString(), name: name);
}
