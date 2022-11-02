import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_box/object_box.dart';
import 'package:shop_core/shop_core.dart';
import 'package:shop_order_repository/shop_order_repository.dart';

import '../home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _Provider(
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}

/// create repositories and provide to app
class _Provider extends StatelessWidget {
  const _Provider({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Create and provide object box ShopOrderRepository
        RepositoryProvider<ShopOrderRepository>(
          lazy: false,
          create: (context) => ObjectBoxShopOrderRepository(
            objectBox: context.read<ObjectBoxProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
