import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/UI/authorithation/login_screen.dart';
import 'package:login/UI/design/gradient_button.dart';

class ProfileScreen extends StatefulWidget {
  int id;
  String login;
  ProfileScreen({super.key, required this.id, this.login = " "});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 128,
                    foregroundImage: AssetImage("assets/images/profile.png"),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Ваш логин: ${widget.login}",
                    style: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GradientButton(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    label: "Выйти",
                  ),
                  SizedBox(
                    height: 600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
