part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  const CustomerState({
    required this.customer,
  });

  final Customer customer;

  @override
  List<Object> get props => [customer];
}

class CustomerInitial extends CustomerState {
  const CustomerInitial({required super.customer});
}

class CustomerUpdated extends CustomerState {
  const CustomerUpdated({required super.customer});
}
