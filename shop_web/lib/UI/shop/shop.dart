import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/UI/design/app_bar_text.dart';
import 'package:login/UI/design/card_product.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: SafeArea(
            child: Column(
          children: [
            Container(
              color: HexColor("181820"),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Container(
                      height: 1,
                      color: HexColor("58dcbe"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      AppBarText(
                        ChangedColor: Colors.blueGrey,
                        title: "Все",
                        onPressed: (){
                          
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.greenAccent,
                        title: "Багет",
                        onPressed: (){
                          
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.cyan,
                        title: "Картины",
                        onPressed: (){
                          
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.red,
                        title: "Краски",
                        onPressed: (){

                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.orangeAccent,
                        title: "Кисти",
                        onPressed: (){

                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 100),
            Center(
                child: Text("ТОВАРЫ ДНЯ",
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontSize: 64,
                        fontWeight: FontWeight.w400))),
            SizedBox(
              height: 60,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 60.0, // горизонтальное расстояние между элементами
              runSpacing: 8.0,
              children: [
                CardProduct(
                  PathImage: "assets/images/mona.jpg",
                  price: 666,
                  title: "Название",
                  onpress: () {},
                ),
                CardProduct(
                  PathImage: "assets/images/long_art.png",
                  price: 5673446,
                  title: "Название",
                  onpress: () {},
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
