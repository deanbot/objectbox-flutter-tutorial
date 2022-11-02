import 'package:equatable/equatable.dart';
import 'package:shop_core/shop_core.dart';

class ShopOrdersResult extends Equatable {
  const ShopOrdersResult({
    required this.results,
    required this.sort,
    required this.direction,
  });

  final List<ShopOrder> results;
  final ShopOrdersSort sort;
  final ShopOrdersSortDirection direction;

  @override
  List<Object> get props => [
        results,
        sort,
        direction,
      ];

  ShopOrdersResult copyWith({
    List<ShopOrder>? results,
    ShopOrdersSort? sort,
    ShopOrdersSortDirection? direction,
  }) {
    return ShopOrdersResult(
      results: results ?? this.results,
      sort: sort ?? this.sort,
      direction: direction ?? this.direction,
    );
  }
}
