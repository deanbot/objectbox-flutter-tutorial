import 'dart:async';

import 'package:shop_core/shop_core.dart';

/// Reactive repository for [ShopOrder] domain.
abstract class ShopOrderRepository {
  const ShopOrderRepository();

  /// Stream of [ShopOrdersResult]
  ///
  /// [add], [remove], [update] actions are reflected in stream.
  ///
  /// If changing sort/filter, the previous results
  /// stream subscription should be manually cancelled
  Stream<ShopOrdersResult> results({
    ShopOrdersSort? sort,
    ShopOrdersSortDirection? direction,
  });

  Future<ShopOrder> get(String id);

  Future<void> add(ShopOrder order);

  /// Will fail if ShopOrder not located
  Future<void> update(ShopOrder order);

  Future<void> remove(String id);

  void dispose();
}