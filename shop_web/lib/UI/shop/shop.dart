import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/BloC/Orders/index.dart';
import 'package:login/BloC/Products/index.dart';
import 'package:login/UI/design/app_bar_text.dart';
import 'package:login/UI/design/card_product.dart';
import 'package:login/UI/design/palette.dart';
import 'package:login/UI/design/plus_center_button.dart';
import 'package:login/models/Products.dart';
import 'package:login/models/orderModel.dart';
import 'package:login/repos/ProductRepos.dart';
import 'package:login/repos/orderRepos.dart';
import 'package:lottie/lottie.dart';
import 'package:file_selector/file_selector.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({super.key, this.IsAdmin = false, this.id_cust = 0});
  bool IsAdmin;
  int id_cust;
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

const List<String> _list = [
  'картина',
  'багет',
  'краска',
  'кисточка',
];

class _ShopScreenState extends State<ShopScreen> {
  ProductsModel model = ProductsModel();
  OrderModel order_model = OrderModel();
  var dio = Dio();
  var byte;
  String title = " ";
  String category = _list[0];
  double price = 0.0;
  int id_cust = 0;
  bool Onec = false;
  bool IsprodDay = true;
  bool isBaget = true;
  bool isProdArt = true;
  bool isProdPaints = true;
  bool isProdBrushes = true;
  bool isProdBaget = true;
  List<Widget> products = [];
  List<Widget> prodDay = [];
  List<Widget> prodBaget = [];
  List<Widget> prodArt = [];
  List<Widget> prodPaints = [];
  List<Widget> prodBrushes = [];
  ProductRepository prodrepos = ProductRepository();
  OrderRepository orderrepos = OrderRepository();

  @override
  Widget build(BuildContext context) {
    var blocblocProduct =
        ProductsBloc(ProductsInitial(), model, prodrepos, dio);
    var blocblocOrder =
        OrdersBloc(OrderInitial(), order_model, orderrepos, dio);
    blocblocProduct.add(LoadListProductsEvent());
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
                        onPressed: () {
                          setState(() {
                            IsprodDay = true;
                            isBaget = true;
                            isProdArt = true;
                            isProdPaints = true;
                            isProdBrushes = true;
                            isProdBaget = true;
                          });
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.greenAccent,
                        title: "Багет",
                        onPressed: () {
                          setState(() {
                            IsprodDay = false;
                            isBaget = false;
                            isProdArt = false;
                            isProdPaints = false;
                            isProdBrushes = false;
                            isProdBaget = true;
                          });
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.cyan,
                        title: "Картины",
                        onPressed: () {
                          setState(() {
                            IsprodDay = false;
                            isBaget = false;
                            isProdArt = true;
                            isProdPaints = false;
                            isProdBrushes = false;
                            isProdBaget = false;
                          });
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.red,
                        title: "Краски",
                        onPressed: () {
                          setState(() {
                            IsprodDay = false;
                            isBaget = false;
                            isProdArt = false;
                            isProdPaints = true;
                            isProdBrushes = false;
                            isProdBaget = false;
                          });
                        },
                      ),
                      AppBarText(
                        ChangedColor: Colors.orangeAccent,
                        title: "Кисти",
                        onPressed: () {
                          setState(() {
                            IsprodDay = false;
                            isBaget = false;
                            isProdArt = false;
                            isProdPaints = false;
                            isProdBrushes = true;
                            isProdBaget = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            if (IsprodDay == true) SizedBox(height: 100),
            if (IsprodDay == true)
              Center(
                  child: Text("ТОВАРЫ ДНЯ",
                      style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.w400))),
            if (IsprodDay == true)
              SizedBox(
                height: 60,
              ),
            if (IsprodDay == true)
              Wrap(
                direction: Axis.horizontal,
                spacing: 60.0, // горизонтальное расстояние между элементами
                runSpacing: 8.0,
                children: [
                  BlocListener<ProductsBloc, ProductsState>(
                      bloc: blocblocProduct,
                      child: Container(),
                      listener: (context, state) {
                        if (Onec == false) {
                          if (state is ListProductsLoaded) {
                            for (var i in state.products) {
                              final bytes = base64Decode(i.photo!);
                              final image = Image.memory(bytes);
                              products.add(CardProduct(
                                PathImage: '',
                                price: i.price!,
                                title: i.title!,
                                onpress: () {
                                  order_model.customer_id = id_cust;
                                  order_model.product_id = i.id;
                                  blocblocOrder.add(OrderAddEvent());
                                },
                                photo: image,
                              ));

                              if (i.category == "картина") {
                                prodArt.add(CardProduct(
                                  PathImage: '',
                                  price: i.price!,
                                  title: i.title!,
                                  onpress: () {
                                    order_model.customer_id = id_cust;
                                    order_model.product_id = i.id;
                                    blocblocOrder.add(OrderAddEvent());
                                  },
                                  photo: image,
                                ));
                              }
                              if (i.category == "краска") {
                                prodPaints.add(CardProduct(
                                  PathImage: '',
                                  price: i.price!,
                                  title: i.title!,
                                  onpress: () {
                                    order_model.customer_id = id_cust;
                                    order_model.product_id = i.id;
                                    blocblocOrder.add(OrderAddEvent());
                                  },
                                  photo: image,
                                ));
                              }
                              if (i.category == "багет") {
                                prodBaget.add(CardProduct(
                                  PathImage: '',
                                  price: i.price!,
                                  title: i.title!,
                                  onpress: () {
                                    order_model.customer_id = id_cust;
                                    order_model.product_id = i.id;
                                    blocblocOrder.add(OrderAddEvent());
                                  },
                                  photo: image,
                                ));
                              }
                              if (i.category == "кисточка") {
                                prodBrushes.add(CardProduct(
                                  PathImage: '',
                                  price: i.price!,
                                  title: i.title!,
                                  onpress: () {
                                    order_model.customer_id = id_cust;
                                    order_model.product_id = i.id;
                                    blocblocOrder.add(OrderAddEvent());
                                  },
                                  photo: image,
                                ));
                              }
                            }
                            products.shuffle(Random());
                            prodDay = products.sublist(0, 8);
                            if (Onec == false) {
                              setState(() {
                                Onec = true;
                              });
                            }
                          }
                        } else if (state is ProductsLoadingFailure) {
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Lottie.asset(
                                  'assets/jsons/flame_cute_man.json',
                                  width: 300,
                                  height: 300,
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  if (widget.IsAdmin == true && IsprodDay == true)
                    PlusCenterWidget(
                      OnPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Создание товара'),
                              content: Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        title = value;

                                        model.title = value;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(27),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Pallete.borderColor,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Pallete.gradient2,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "Название товара",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        price = double.parse(value);
                                        model.price = price;
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(27),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Pallete.borderColor,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Pallete.gradient2,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "Цена",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CustomDropdown<String>(
                                      expandedFillColor: HexColor("#43414b"),
                                      closedFillColor: HexColor("#43414b"),
                                      hintText: 'Выберите категорию',
                                      items: _list,
                                      initialItem: _list[0],
                                      onChanged: (value) {
                                        model.category = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          XTypeGroup typeGroup = XTypeGroup(
                                            label: 'images',
                                            extensions: <String>[
                                              'jpg',
                                              'png',
                                              'jpeg'
                                            ],
                                          );
                                          final XFile? file = await openFile(
                                              acceptedTypeGroups: <XTypeGroup>[
                                                typeGroup
                                              ]);

                                          byte = file;
                                          model.file = file;
                                        },
                                        child: Text("Выбрать картинку")),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Закрыть'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    blocblocProduct.add(LoadProductsEvent());
                                    Navigator.pop(context);

                                    setState(() {
                                      products.clear();
                                    });
                                    blocblocProduct
                                        .add(LoadListProductsEvent());
                                  },
                                  child: Text('Сохранить'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      dash: true,
                    ),
                  if (IsprodDay == true) ...prodDay,
                ],
              ),
            if (isProdPaints == true) SizedBox(height: 100),
            if (isProdPaints == true)
              Center(
                  child: Text("Краски",
                      style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.w400))),
            if (isProdPaints == true)
              SizedBox(
                height: 60,
              ),
            if (isProdPaints == true)
              Wrap(
                direction: Axis.horizontal,
                spacing: 60.0, // горизонтальное расстояние между элементами
                runSpacing: 8.0,
                children: [
                  ...prodPaints,
                ],
              ),
            if (isProdBaget == true) SizedBox(height: 100),
            if (isProdBaget == true)
              Center(
                  child: Text("Багет",
                      style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.w400))),
            if (isProdBaget == true)
              SizedBox(
                height: 60,
              ),
            if (isProdBaget == true)
              Wrap(
                direction: Axis.horizontal,
                spacing: 60.0, // горизонтальное расстояние между элементами
                runSpacing: 8.0,
                children: [
                  ...prodBaget,
                ],
              ),
            if (isProdBrushes == true) SizedBox(height: 100),
            if (isProdBrushes == true)
              Center(
                  child: Text("Кисти",
                      style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.w400))),
            if (isProdBrushes == true)
              SizedBox(
                height: 60,
              ),
            if (isProdBrushes == true)
              Wrap(
                direction: Axis.horizontal,
                spacing: 60.0, // горизонтальное расстояние между элементами
                runSpacing: 8.0,
                children: [
                  ...prodBrushes,
                ],
              ),
            if (isProdArt == true) SizedBox(height: 100),
            if (isProdArt == true)
              Center(
                  child: Text("Картины",
                      style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.w400))),
            if (isProdArt == true)
              SizedBox(
                height: 60,
              ),
            if (isProdArt == true)
              Wrap(
                direction: Axis.horizontal,
                spacing: 60.0, // горизонтальное расстояние между элементами
                runSpacing: 8.0,
                children: [
                  ...prodArt,
                ],
              ),
          ],
        )),
      ),
    );
  }
}
