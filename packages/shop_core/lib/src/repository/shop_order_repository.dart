import 'package:shop_core/shop_core.dart';

/// Reactive ShopOrder repository
abstract class ShopOrderRepository {
  const ShopOrderRepository();

  Stream<List<ShopOrder>> list();

  Future<void> sort({
    required ShopOrdersSort sort,
    required ShopOrdersSortDirection direction,
  });

  Future<void> add(ShopOrder order);

  Future<void> remove(String id);
}
