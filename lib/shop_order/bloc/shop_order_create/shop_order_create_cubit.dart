import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:shop_core/shop_core.dart';

part 'shop_order_create_state.dart';

class ShopOrderCreateCubit extends Cubit<ShopOrderCreateState> {
  ShopOrderCreateCubit({required ShopOrderRepository shopOrderRepository})
      : _shopOrderRepository = shopOrderRepository,
        super(ShopOrderCreateInitial());
  final ShopOrderRepository _shopOrderRepository;

  final _faker = Faker();

  /// Create random order for customer
  Future<void> create(Customer customer) async {
    emit(ShopOrderCreateInProgress());

    try {
      final shopOrder = ShopOrder(
        id: '0',
        customer: customer,
        price: _faker.randomGenerator.integer(500, min: 10).toDouble(),
      );
      _shopOrderRepository.add(shopOrder);
      emit(ShopOrderCreateSuccess());
    } catch (_) {
      log(_.toString());
      emit(ShopOrderCreateError());
    }
  }
}
