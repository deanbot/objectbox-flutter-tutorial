import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_core/shop_core.dart';

part 'shop_order_remove_state.dart';

class ShopOrderRemoveCubit extends Cubit<ShopOrderRemoveState> {
  ShopOrderRemoveCubit({required ShopOrderRepository shopOrderRepository})
      : _shopOrderRepository = shopOrderRepository,
        super(ShopOrderRemoveInitial());

  final ShopOrderRepository _shopOrderRepository;

  void remove(String id) {
    emit(const ShopOrderRemoveInProgress());

    try {
      _shopOrderRepository.remove(id);
      emit(const ShopOrderRemoveSuccess());
    } catch (_) {
      emit(const ShopOrderRemoveError());
    }
  }
}
