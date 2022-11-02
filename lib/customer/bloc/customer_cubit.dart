import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:shop_core/shop_core.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial(customer: _newCustomer));

  static final Faker _faker = Faker();

  /// set a new random customer
  void randomizeCustomer() => emit(CustomerUpdated(customer: _newCustomer));

  static Customer get _newCustomer => Customer(
        id: '0',
        name: _faker.person.name(),
      );
}
