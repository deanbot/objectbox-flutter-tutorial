part of 'customer_shop_orders_cubit.dart';

abstract class CustomerShopOrdersState extends Equatable {
  const CustomerShopOrdersState({required this.orders});

  final List<ShopOrder> orders;

  @override
  List<Object> get props => [orders];
}

class CustomerShopOrdersInitial extends CustomerShopOrdersState {
  const CustomerShopOrdersInitial({
    super.orders = const [],
  });
}

class CustomerShopOrdersLoading extends CustomerShopOrdersState {
  const CustomerShopOrdersLoading({
    super.orders = const [],
  });
}

class CustomerShopOrdersError extends CustomerShopOrdersState {
  const CustomerShopOrdersError({
    super.orders = const [],
  });
}

class CustomerShopOrdersSuccess extends CustomerShopOrdersState {
  const CustomerShopOrdersSuccess({
    required super.orders,
  });
}