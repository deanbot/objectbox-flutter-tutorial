import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox_tutorial/shop_order/shop_order.dart';
import 'package:shop_core/shop_core.dart';

/// Order table showing shop orders and allowing order deletion
class ShopOrdersDataTable extends StatelessWidget {
  const ShopOrdersDataTable();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopOrdersCubit(
            shopOrderRepository: context.read<ShopOrderRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ShopOrderRemoveCubit(
            shopOrderRepository: context.read<ShopOrderRepository>(),
          ),
        ),
      ],
      child: BlocListener<ShopOrderRemoveCubit, ShopOrderRemoveState>(
        listener: (context, state) {
          if (state is ShopOrderRemoveSuccess) {
            // show success message
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Order removed'),
              ));
          } else if (state is ShopOrderRemoveError) {
            // show success message
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Problem removing order'),
              ));
          }
        },
        child: const _TableWrapper(
          child: _Table(),
        ),
      ),
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
    return BlocBuilder<ShopOrdersCubit, ShopOrdersState>(
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
    );
  }

  void _onDataColumnSort(int columnIndex, bool ascending) {
    final sort = _sortByIndex(columnIndex);
    if (sort == null){
      return;
    }

    final ShopOrdersSortDirection direction = ascending
        ? ShopOrdersSortDirection.ascending
        : ShopOrdersSortDirection.descending;
    context.read<ShopOrdersCubit>().sort(sort: sort, direction: direction);
  }

  void _onTapDelete(ShopOrder order) {
    context.read<ShopOrderRemoveCubit>().remove(order.id);
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

  /// Return sort by [DataTable] column index
  ShopOrdersSort? _sortByIndex(int index) {
    late final ShopOrdersSort? sort;
    if (index == _indexId) {
      sort = ShopOrdersSort.id;
    } else if (index == _indexPrice) {
      sort = ShopOrdersSort.price;
    } else {
      // sort not supported
      sort = null;
    }
    return sort;
  }


  /// Return [DataTable] sort column index by sort
  int _indexBySort(ShopOrdersSort sort) {
    if (sort == ShopOrdersSort.price) {
      return _indexPrice;
    } else {
      return _indexId;
    }
  }

  /// Return [DataTable] sort ascending by direction
  bool _ascendingByDirection(ShopOrdersSortDirection direction) =>
      direction == ShopOrdersSortDirection.ascending;
}

/// Scroll view wrapper
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
