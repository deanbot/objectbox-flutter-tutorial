import 'package:equatable/equatable.dart';
import 'package:shop_core/src/models/customer.dart';

class ShopOrder extends Equatable {
  const ShopOrder({
    required this.id,
    required this.price,
    required this.customer,
  });

  final String id;
  final Customer customer;
  final double price;

  @override
  List<Object> get props => [id, price, customer];

  ShopOrder copyWith({
    String? id,
    Customer? customer,
    double? price,
  }) {
    return ShopOrder(
      customer: customer ?? this.customer,
      id: id ?? this.id,
      price: price ?? this.price,
    );
  }
}
