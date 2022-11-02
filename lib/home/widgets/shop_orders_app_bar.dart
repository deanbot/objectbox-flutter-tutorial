import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox_tutorial/customer/customer.dart';
import 'package:objectbox_tutorial/shop_order/shop_order.dart';
import 'package:shop_core/shop_core.dart';

/// App bar allows changing customer selection and creating orders for selected customer
class ShopOrdersAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ShopOrdersAppBar({Key? key}) : super(key: key);

  @override
  State<ShopOrdersAppBar> createState() => _ShopOrdersAppBarState();

  static const double _toolbarHeight = kToolbarHeight;
  static const double _bottomHeight = 0;

  @override
  final Size preferredSize =
      const Size.fromHeight(_toolbarHeight + _bottomHeight);
}

class _ShopOrdersAppBarState extends State<ShopOrdersAppBar> {
  late final CustomerCubit _customerCubit;
  late final ShopOrderCreateCubit _shopOrderCreateCubit;

  @override
  void initState() {
    super.initState();
    _customerCubit = CustomerCubit();
    _shopOrderCreateCubit = ShopOrderCreateCubit(
      shopOrderRepository: context.read<ShopOrderRepository>(),
    );
  }

  @override
  void dispose() {
    _customerCubit.close();
    _shopOrderCreateCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Orders App'),
      // icon buttons and event handlers
      actions: [
        BlocProvider.value(
          value: _customerCubit,
          child: _CustomerListener(
            child: const _RandomizeCustomerIconButton(),
          ),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _customerCubit),
            BlocProvider.value(value: _shopOrderCreateCubit),
          ],
          child: const _ShopOrderCreateListener(
            child: _NewOrderIconButton(),
          ),
        ),
      ],
    );
  }
}

/// Button which triggers randomize customer
class _RandomizeCustomerIconButton extends StatelessWidget {
  const _RandomizeCustomerIconButton();

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.person_add_alt),
        onPressed: () => context.read<CustomerCubit>().randomizeCustomer(),
      );
}

/// Button which triggers order create with customer
class _NewOrderIconButton extends StatelessWidget {
  const _NewOrderIconButton();

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.attach_money),
        onPressed: () {
          final customer = context.read<CustomerCubit>().state.customer;
          context.read<ShopOrderCreateCubit>().create(customer);
        },
      );
}

/// Show [SnackBar] on customer randomized
class _CustomerListener extends StatelessWidget {
  const _CustomerListener({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is CustomerUpdated) {
          // show success message
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('Customer randomized.'),
            ));
        }
      },
      child: child,
    );
  }
}

/// Show [SnackBar] on order create success
class _ShopOrderCreateListener extends StatelessWidget {
  const _ShopOrderCreateListener({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopOrderCreateCubit, ShopOrderCreateState>(
      listener: (context, state) {
        if (state is ShopOrderCreateSuccess) {
          // show success message
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('Shop order created.'),
            ));
        }
      },
      child: child,
    );
  }
}
