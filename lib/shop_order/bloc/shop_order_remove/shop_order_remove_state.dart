part of 'shop_order_remove_cubit.dart';

abstract class ShopOrderRemoveState extends Equatable {
  const ShopOrderRemoveState();

  @override
  List<Object> get props => [];
}

class ShopOrderRemoveInitial extends ShopOrderRemoveState {
  const ShopOrderRemoveInitial();
}

class ShopOrderRemoveInProgress extends ShopOrderRemoveState {
  const ShopOrderRemoveInProgress();
}

class ShopOrderRemoveSuccess extends ShopOrderRemoveState {
  const ShopOrderRemoveSuccess();
}

class ShopOrderRemoveError extends ShopOrderRemoveState {
  const ShopOrderRemoveError();
}
