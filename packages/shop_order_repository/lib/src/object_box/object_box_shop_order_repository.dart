import 'dart:async';

import 'package:shop_core/shop_core.dart';
import 'package:object_box/object_box.dart';

/// [ShopOrderRepository] implementation using [ObjectBoxProvider]
class ObjectBoxShopOrderRepository extends ShopOrderRepository {
  const ObjectBoxShopOrderRepository({required ObjectBoxProvider objectBox})
      : _objectBox = objectBox;

  final ObjectBoxProvider _objectBox;

  @override
  Future<void> add(ShopOrder order) async {
    _objectBox.putOrder(order.toEntity);
  }

  @override
  Future<void> update(ShopOrder order) async {
    _objectBox.updateOrder(order.toEntity);
  }

  @override
  Future<void> remove(String id) async {
    _objectBox.removeOrder(int.parse(id));
  }

  @override
  Future<ShopOrder> get(String id) async {
    final result = _objectBox.getOrder(int.parse(id));
    if (result == null) {
      // TODO : customer exception
      throw Exception('not found');
    }
    return result.toDomain;
  }

  static const _defaultSort = ShopOrdersSort.id;
  static const _defaultDirection = ShopOrdersSortDirection.ascending;

  @override
  Stream<ShopOrdersResult> results({
    ShopOrdersSort? sort = _defaultSort,
    ShopOrdersSortDirection? direction = _defaultDirection,
  }) {
    final property = _queryPropertyBySort(sort ?? _defaultSort);
    final flags = _flagsByDirection(direction ?? _defaultDirection);
    final builder = _objectBox.shopOrdersBox.query();
    builder
      ..order(
        property,
        flags: flags,
      );
    return builder
        // TODO : should this be cached and cancelled?
        .watch(
            triggerImmediately:
                true) // final _subscription = ... subscription.cancel
        .map<List<ShopOrder>>((Query<ShopOrderEntity> event) =>
            event.find().map((element) => element.toDomain).toList())
        .map<ShopOrdersResult>((results) => ShopOrdersResult(
              results: results,
              sort: _defaultSort,
              direction: _defaultDirection,
            ));
  }

  /// map sort to entity query property
  QueryProperty<ShopOrderEntity, dynamic> _queryPropertyBySort(
      ShopOrdersSort sort) {
    switch (sort) {
      case ShopOrdersSort.price:
        return ShopOrderEntity_.price;
      case ShopOrdersSort.id:
      case ShopOrdersSort.none:
        return ShopOrderEntity_.id;
    }
  }

  /// map direction to query order flag
  int _flagsByDirection(ShopOrdersSortDirection direction) {
    switch (direction) {
      case ShopOrdersSortDirection.descending:
        return Order.descending;
      case ShopOrdersSortDirection.ascending:
      case ShopOrdersSortDirection.none:
        return 0;
    }
  }

  @override
  void dispose() {}
}

// TODO : Support uuid strings for id (typical of api response and reflected in domain model)
/// Domain to entity mapping of [ShopOrder]
extension _ShopOrderExtension on ShopOrder {
  ShopOrderEntity get toEntity =>
      ShopOrderEntity(id: int.parse(id), price: price)
        ..customer.target = customer.toEntity;
}

/// Entity to domain mapping of [shopOrderEntity]
extension _ShopOrderEntityExtension on ShopOrderEntity {
  ShopOrder get toDomain => ShopOrder(
      id: id.toString(), price: price, customer: customer.target!.toDomain);
}

/// Domain to entity mapping of [Customer]
extension _CustomerExtension on Customer {
  CustomerEntity get toEntity => CustomerEntity(id: int.parse(id), name: name);
}

/// Entity to domain mapping of [CusotmerEntity]
extension _CustomerEntityExtension on CustomerEntity {
  Customer get toDomain => Customer(id: id.toString(), name: name);
}
