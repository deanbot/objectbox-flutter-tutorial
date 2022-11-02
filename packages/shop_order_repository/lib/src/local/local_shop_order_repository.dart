import 'package:shop_core/shop_core.dart';
import 'package:object_box/object_box.dart';
import 'package:shop_order_repository/src/local/mapping.dart';

class LocalShopOrderRepository extends ShopOrderRepository {
  LocalShopOrderRepository({required ObjectBox objectBox})
      : _objectBox = objectBox;

  final ObjectBox _objectBox;

  QueryBuilder<ShopOrderEntity> get _query =>
      _objectBox.store.box<ShopOrderEntity>().query();

  @override
  Stream<List<ShopOrder>> list() => _watch(_query);

  @override
  Future<void> add(ShopOrder order) async {
    _objectBox.store.box<ShopOrderEntity>().put(order.toEntity);
  }

  @override
  Future<void> sort({
    required ShopOrdersSort sort,
    required ShopOrdersSortDirection direction,
  }) async =>
      _order(
        query: _query,
        sort: sort,
        direction: direction,
      )..build();

  @override
  Future<void> remove(String id) async {
    _objectBox.store.box<ShopOrderEntity>().remove(int.parse(id));
  }

  /// Get [ShopOrder] stream from [QueryBuilder] of [ShopOrderEntity]
  Stream<List<ShopOrder>> _watch(QueryBuilder<ShopOrderEntity> query) => query
      .watch(triggerImmediately: true)
      .map((query) => query.find().map((element) => element.toDomain).toList());

  /// Apply ordering to [QueryBuilder] of [ShopOrderEntity]
  QueryBuilder<ShopOrderEntity> _order({
    required QueryBuilder<ShopOrderEntity> query,
    required ShopOrdersSort sort,
    required ShopOrdersSortDirection direction,
  }) {
    // set sort field
    late final sortField;
    switch (sort) {
      case ShopOrdersSort.price:
        sortField = ShopOrderEntity_.price;
        break;
      case ShopOrdersSort.id:
      default:
        sortField = ShopOrderEntity_.id;
        break;
      // TODO : sort by customer
    }

    // set direction flags
    late final flags;
    switch (direction) {
      case ShopOrdersSortDirection.descending:
        flags = Order.descending;
        break;
      case ShopOrdersSortDirection.ascending:
      default:
        flags = 0;
        break;
    }
    query
      ..order(
        sortField,
        flags: flags,
      );
    return query;
  }
}
