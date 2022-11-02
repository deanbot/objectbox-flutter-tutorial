import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];

  Customer copyWith({
    String? id,
    String? name,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
