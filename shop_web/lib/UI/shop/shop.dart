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
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Align(
        alignment: Alignment.topCenter,
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
                      ),
                      AppBarText(
                        ChangedColor: Colors.greenAccent,
                        title: "Багет",
                      ),
                      AppBarText(
                        ChangedColor: Colors.cyan,
                        title: "Картины",
                      ),
                      AppBarText(
                        ChangedColor: Colors.red,
                        title: "Краски",
                      ),
                      AppBarText(
                        ChangedColor: Colors.orangeAccent,
                        title: "Кисти",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 120),
            Center(
                child: Text("ТОВАРЫ ДНЯ",
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontSize: 64,
                        fontWeight: FontWeight.w400))),
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                CardProduct(
                  PathImage: "assets/images/mona.jpg",
                  price: 666,
                  title: "Название",
                  onpress: () {},
                ),
                SizedBox(
                  width: 60,
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
        ),
      )),
    );
  }
}
