import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/UI/authorithation/forget_password.dart';
import 'package:login/UI/authorithation/registration_screen.dart';
import 'package:login/UI/authorithation/reg_verification_screen.dart';
import 'package:login/UI/design/gradient_button.dart';
import 'package:login/UI/design/login_field.dart';

import 'package:login/UI/design/social_button.dart';
import 'package:login/UI/shop/administration_panel.dart';
import 'package:login/UI/shop/shop.dart';

class ShopRewiew extends StatefulWidget {
  bool Isadmin;
  ShopRewiew({Key? key, required this.Isadmin}) : super(key: key);

  @override
  _ShopRewiew createState() => _ShopRewiew();
}

class _ShopRewiew extends State<ShopRewiew> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return widget.Isadmin
        ? DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.shop),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.shopping_bag),
                ),
                Tab(
                  icon: Icon(Icons.support_agent),
                ),
                Tab(
                  icon: Icon(Icons.admin_panel_settings_outlined),
                ),
              ]),
              body: TabBarView(children: [
                ShopScreen(),
                Container(
                  color: Colors.pink,
                  child: Icon(Icons.person),
                ),
                Container(
                  color: Colors.green,
                  child: Icon(Icons.shopping_bag),
                ),
                Container(
                  color: Colors.blue,
                  child: Icon(Icons.support_agent),
                ),
                AdminScreen(),
              ]),
            ),
          )
        : DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.shop),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.shopping_bag),
                ),
                Tab(
                  icon: Icon(Icons.support_agent),
                ),
              ]),
              body: TabBarView(children: [
                ShopScreen(),
                Container(
                  color: Colors.pink,
                  child: Icon(Icons.person),
                ),
                Container(
                  color: Colors.green,
                  child: Icon(Icons.shopping_bag),
                ),
                Container(
                  color: Colors.blue,
                  child: Icon(Icons.support_agent),
                ),
              ]),
            ),
          );
  }
}
