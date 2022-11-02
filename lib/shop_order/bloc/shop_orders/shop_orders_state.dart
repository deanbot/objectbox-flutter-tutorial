part of 'shop_orders_cubit.dart';

abstract class ShopOrdersState extends Equatable {
  const ShopOrdersState({
    required this.shopOrders,
    required this.sort,
    required this.direction,
  });

  final List<ShopOrder> shopOrders;
  final ShopOrdersSort sort;
  final ShopOrdersSortDirection direction;

  @override
  List<Object> get props => [shopOrders, sort, direction];
}

/// Default sort/direction
class ShopOrdersInitial extends ShopOrdersState {
  const ShopOrdersInitial({
    super.shopOrders = const [],
    super.sort = ShopOrdersSort.id,
    super.direction = ShopOrdersSortDirection.ascending,
  });
}

/// Changed sort or direction or orders
class ShopOrdersUpdated extends ShopOrdersState {
  const ShopOrdersUpdated({
    required super.shopOrders,
    required super.sort,
    required super.direction,
  });
}

class ShopOrdersUpdating extends ShopOrdersUpdated {
  const ShopOrdersUpdating({
    required super.shopOrders,
    required super.sort,
    required super.direction,
  });
}

class ShopOrdersUpdateError extends ShopOrdersUpdated {
  const ShopOrdersUpdateError({
    required super.shopOrders,
    required super.sort,
    required super.direction,
  });
}
