import 'package:flutter/material.dart';

class OrderDataTable extends StatefulWidget {
  // final List<ShopOrder> orders;
  final void Function(int columnIndex, bool ascending) onSort;

  // final Store store;

  const OrderDataTable({
    Key? key,
    // required this.orders,
    required this.onSort,
    // required this.store,
  }) : super(key: key);

  @override
  _OrderDataTableState createState() => _OrderDataTableState();
}

class _OrderDataTableState extends State<OrderDataTable> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text('ID'),
              onSort: _onDataColumnSort,
            ),
            DataColumn(
              label: Text('Customer'),
            ),
            DataColumn(
              label: Text('Price'),
              numeric: true,
              onSort: _onDataColumnSort,
            ),
            DataColumn(
              label: Container(),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(
                  Text('ID'),
                ),
                DataCell(
                  Text(
                    'CUSTOMER NAME',
                  ),
                  onTap: () {},
                ),
                DataCell(
                  Text('\$PRICE'),
                ),
                DataCell(
                  Icon(Icons.delete),
                  onTap: () {
                    // TODO : Delete the order from the database
                  },
                )
              ],
            ),
          ],
          /*widget.orders.map(
            (order) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(order.id.toString()),
                  ),
                  DataCell(
                    Text(order.customer.target?.name ?? 'NONE'),
                    onTap: () {
                      showModalBottomSheet(
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
                      );
                    },
                  ),
                  DataCell(
                    Text(
                      '\$${order.price}',
                    ),
                  ),
                  DataCell(
                    Icon(Icons.delete),
                    onTap: () {
                      widget.store.box<ShopOrder>().remove(order.id);
                    },
                  ),
                ],
              );
            },
          ).toList(),*/
        ),
      ),
    );
  }

  void _onDataColumnSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
    widget.onSort(columnIndex, ascending);
  }
}
