import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/BloC/Orders/index.dart';
import 'package:login/BloC/Products/index.dart';
import 'package:login/UI/design/card_product_row.dart';
import 'package:login/models/Products.dart';
import 'package:login/models/orderModel.dart';
import 'package:login/repos/ProductRepos.dart';
import 'package:login/repos/orderRepos.dart';

class CartScreen extends StatefulWidget {
  final double price;
  final String title;
  final int id_cust;
  bool Onec;

  Image? photo;
  CartScreen(
      {super.key,
      this.photo,
      this.price = 0.0,
      this.title = '',
      required this.id_cust,
      this.Onec = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductsModel order_model = ProductsModel();
  List<ProductsModel> prod = [];
  var dio = Dio();
  ProductRepository orderrepos = ProductRepository();
  OrderModel order_model1 = OrderModel();

  OrderRepository orderrepos1 = OrderRepository();
  List<Widget> cart = [];
  List<int> id_products = [];
  List<int> id_ord = [];
  @override
  initState() {
    widget.Onec = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _ordersBlocBloc =
        OrdersBloc(OrderInitial(), order_model1, orderrepos1, dio);

    order_model1.customer_id = widget.id_cust;
    var _productBlocBloc =
        ProductsBloc(ProductsInitial(), order_model, orderrepos, dio);

    _ordersBlocBloc.add(OrderSelectEvent());

    return SingleChildScrollView(
      child: Column(
        children: [
          BlocListener<OrdersBloc, OrdersState>(
              bloc: _ordersBlocBloc,
              child: Container(),
              listener: (context, state) async {
                if (state is OrderListLoaded) {
                  for (var i in state.order) {
                    print(i.product_id);
                    id_products.add(i.product_id!);
                    id_ord.add(i.id!);
                  }
                  for (int i = 0; i < id_products.length; i++) {
                    ProductsModel product =
                        await orderrepos.getProductsById(id_products[i]);
                    product.id_ord = id_ord[i];
                    prod.add(product);
                  }
                  for (var i in prod) {
                    final bytes = base64Decode(i.photo!);
                    final image = Image.memory(bytes);
                    cart.add(CardProductRow(
                      photo: image,
                      price: i.price!,
                      title: i.title!,
                      id_ord: i.id_ord,
                    ));
                  }
                  if (widget.Onec == false)
                    setState(() {
                      widget.Onec = true;
                    });
                }
              }),
         
          ...cart,
        ],
      ),
    );
  }
}
