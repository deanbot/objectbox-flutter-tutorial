import 'package:flutter/material.dart';
import 'package:objectbox_tutorial/home/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO : loading
    /*!hasBeenInitialized
        ? Center(child: CircularProgressIndicator(),)
        : ...
    )*/
    return Scaffold(
      appBar: const ShopOrdersAppBar(),
      body: const ShopOrdersDataTable(),
    );
  }
}
