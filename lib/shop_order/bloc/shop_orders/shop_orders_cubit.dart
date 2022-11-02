import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_core/shop_core.dart';

part 'shop_orders_state.dart';

class ShopOrdersCubit extends Cubit<ShopOrdersState> {
  ShopOrdersCubit({
    required ShopOrderRepository shopOrderRepository,
  })  : _shopOrderRepository = shopOrderRepository,
        super(ShopOrdersInitial()) {
    _subscription = _shopOrderRepository.results().listen(_handleUpdated);
  }

  final ShopOrderRepository _shopOrderRepository;
  late final StreamSubscription<ShopOrdersResult> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  Future<void> sort({
    required ShopOrdersSort sort,
    required ShopOrdersSortDirection direction,
  }) async {
    if (state is ShopOrdersUpdating) {
      return;
    }
    final prevSort = state.sort;
    final prevDirection = state.direction;
    final prevShopOrders = state.shopOrders;
    emit(ShopOrdersUpdating(
      shopOrders: prevShopOrders,
      sort: sort,
      direction: direction,
    ));
    try {
      _subscription.cancel();
      _subscription = _shopOrderRepository
          .results(sort: sort, direction: direction)
          .listen(_handleUpdated);
    } catch (_) {
      emit(ShopOrdersUpdateError(
        sort: prevSort,
        direction: prevDirection,
        shopOrders: prevShopOrders,
      ));
    }
  }

  void _handleUpdated(value) => emit(ShopOrdersUpdated(
        shopOrders: value.results,
        sort: value.sort,
        direction: value.direction,
      ));
}
