import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox_tutorial/shop_order/shop_order.dart';
import 'package:shop_core/shop_core.dart';

class ShopOrdersDataTable extends StatelessWidget {
  const ShopOrdersDataTable();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopOrdersCubit(
        shopOrderRepository: context.read<ShopOrderRepository>(),
      ),
      child: const _Table(),
    );
  }
}

class _Table extends StatefulWidget {
  const _Table();

  @override
  State<_Table> createState() => _TableState();
}

class _TableState extends State<_Table> {
  static const _indexId = 0;
  static const _indexPrice = 2;

  @override
  Widget build(BuildContext context) {
    return _TableWrapper(
      child: BlocBuilder<ShopOrdersCubit, ShopOrdersState>(
        builder: (context, state) {
          // convert sort and direction
          final _sortColumnIndex = _indexBySort(state.sort);
          final _sortAscending = _ascendingByDirection(state.direction);
          return DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              // i.e. _indexId
              DataColumn(
                label: Text('ID'),
                onSort: _onDataColumnSort,
              ),
              DataColumn(
                label: Text('Customer'),
              ),
              // i.e. _indexPrice
              DataColumn(
                label: Text('Price'),
                numeric: true,
                onSort: _onDataColumnSort,
              ),
              DataColumn(
                label: Container(),
              ),
            ],
            rows: state.shopOrders.map((order) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(order.id.toString()),
                  ),
                  DataCell(
                    Text(order.customer.name),
                    onTap: _onTapName,
                  ),
                  DataCell(
                    Text(
                      '\$${order.price}',
                    ),
                  ),
                  DataCell(
                    Icon(Icons.delete),
                    onTap: () => _onTapDelete(order),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _onDataColumnSort(int columnIndex, bool ascending) {
    late final ShopOrdersSort? sort;
    if (columnIndex == _indexId) {
      sort = ShopOrdersSort.id;
    } else if (columnIndex == _indexPrice) {
      sort = ShopOrdersSort.price;
    } else {
      // sort not supported
      sort = null;
      return;
    }

    final ShopOrdersSortDirection direction = ascending
        ? ShopOrdersSortDirection.ascending
        : ShopOrdersSortDirection.descending;
    context.read<ShopOrdersCubit>().sort(sort: sort, direction: direction);
  }

  void _onTapDelete(ShopOrder order) {
    context.read<ShopOrdersCubit>().remove(order.id);
  }

  void _onTapName() {
/*    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Material(
          child: ListView(
            children: order.customer.target!.orders
                .map(
                  (_) => ListTile(
                title: Text(
                    '${_.id}    ${_.customer.target?.name}    \$${_.price}'),
              ),
            )
                .toList(),
          ),
        );
      },
    );*/
  }

  /// return [DataTable] sort column index by sort
  int _indexBySort(ShopOrdersSort sort) {
    if (sort == ShopOrdersSort.price) {
      return _indexPrice;
    } else {
      return _indexId;
    }
  }

  /// return [DataTable] sort ascending by direction
  bool _ascendingByDirection(ShopOrdersSortDirection direction) =>
      direction == ShopOrdersSortDirection.ascending;
}

class _TableWrapper extends StatelessWidget {
  const _TableWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
