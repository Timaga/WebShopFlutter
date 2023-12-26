import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/BloC/Orders/index.dart';
import 'package:login/models/orderModel.dart';
import 'package:login/repos/orderRepos.dart';

class CardProduct extends StatefulWidget {
  final String PathImage;
  final double price;
  final String title;
  final int id;
  final int id_cust;

  Image photo;
  final VoidCallback onpress;
  CardProduct(
      {super.key,
      required this.id_cust,
      required this.id,
      required this.PathImage,
      required this.price,
      required this.title,
      required this.onpress,
      required this.photo});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  OrderModel order_model = OrderModel();
  OrderRepository orderrepos = OrderRepository();
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    var blocblocOrder =
        OrdersBloc(OrderInitial(), order_model, orderrepos, dio);
    return InkWell(
      onTap: () {
        order_model.product_id = widget.id;
        order_model.customer_id = widget.id_cust;
        blocblocOrder.add(OrderAddEvent());
      },
      child: Column(
        children: [
          Container(
            height: 300,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: widget.photo.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${widget.price} ₽",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
