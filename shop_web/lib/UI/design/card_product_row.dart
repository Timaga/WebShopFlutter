import 'package:flutter/material.dart';
import 'package:login/repos/orderRepos.dart';

class CardProductRow extends StatefulWidget {
  final double price;
  final String title;
  final int id_cust;
  final int id_ord;
  Image? photo;
  
  CardProductRow(
      {super.key,
      required this.photo,
      required this.price,
      required this.title,
      required this.id_ord,
      this.id_cust = 0});

  @override
  State<CardProductRow> createState() => _CardProductRowState();
}

class _CardProductRowState extends State<CardProductRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(64),
          ),
          height: 300,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  height: 200,
                  image: widget.photo!.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${widget.price} ₽",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: () {
                setState(() async{
                  await OrderRepository().DeleteOrder(widget.id_ord) ;
                });
              }, child: Text("Удалить")),
            ],
          ),
        ),
      ],
    );
  }
}
