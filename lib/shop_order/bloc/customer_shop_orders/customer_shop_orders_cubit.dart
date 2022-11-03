import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_core/shop_core.dart';

part 'customer_shop_orders_state.dart';

class CustomerShopOrdersCubit extends Cubit<CustomerShopOrdersState> {
  CustomerShopOrdersCubit() : super(CustomerShopOrdersInitial());
}
