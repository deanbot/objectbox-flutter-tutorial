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
    // TODO : subscribe to stream
    _subscription = _shopOrderRepository.list().listen((value) {
      // consume in mem sort
      emit(ShopOrdersUpdated(
        shopOrders: value,
        sort: state.sort,
        direction: state.direction,
      ));
    });
  }

  final ShopOrderRepository _shopOrderRepository;
  late StreamSubscription<List<ShopOrder>> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  Future<void> remove(id) async {
    emit(ShopOrdersUpdating(
      shopOrders: state.shopOrders,
      sort: state.sort,
      direction: state.direction,
    ));
    try {
      // TODO : if dropping 'reactive' emit result
      _shopOrderRepository.remove(id);
      await Future.delayed(Duration.zero);
    } catch (_) {
      emit(ShopOrdersUpdateError(
        shopOrders: state.shopOrders,
        sort: state.sort,
        direction: state.direction,
      ));
    }
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
      // TODO : if dropping 'reactive' emit result
      _shopOrderRepository.sort(sort: sort, direction: direction);
      await Future.delayed(Duration.zero);
    } catch (_) {
      emit(ShopOrdersUpdateError(
        sort: prevSort,
        direction: prevDirection,
        shopOrders: prevShopOrders,
      ));
    }
  }
}
