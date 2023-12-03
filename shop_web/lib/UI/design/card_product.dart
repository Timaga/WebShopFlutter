import 'package:flutter/material.dart';

class CardProduct extends StatefulWidget {
  final String PathImage;
  final int price;
  final String title;
  final Function onpress;
  const CardProduct(
      {super.key,
      required this.PathImage,
      required this.price,
      required this.title,
      required this.onpress});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onpress;
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
                image: AssetImage(widget.PathImage),
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
