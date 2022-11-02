part of 'shop_order_create_cubit.dart';

abstract class ShopOrderCreateState extends Equatable {
  const ShopOrderCreateState();
  @override
  List<Object> get props => [];
}

class ShopOrderCreateInitial extends ShopOrderCreateState {
  const ShopOrderCreateInitial();
}

class ShopOrderCreateInProgress extends ShopOrderCreateState {
  const ShopOrderCreateInProgress();
}

class ShopOrderCreateSuccess extends ShopOrderCreateState {
  const ShopOrderCreateSuccess();
}

class ShopOrderCreateError extends ShopOrderCreateState {
  const ShopOrderCreateError();
}
