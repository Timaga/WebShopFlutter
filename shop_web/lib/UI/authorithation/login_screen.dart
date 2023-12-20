import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/BloC/AuthBloc/AuthBloc_bloc.dart';
import 'package:login/BloC/AuthBloc/index.dart';
import 'package:login/UI/authorithation/forget_password.dart';
import 'package:login/UI/authorithation/registration_screen.dart';
import 'package:login/UI/authorithation/reg_verification_screen.dart';
import 'package:login/UI/design/gradient_button.dart';
import 'package:login/UI/design/login_field.dart';
import 'package:login/UI/design/palette.dart';

import 'package:login/UI/design/social_button.dart';
import 'package:login/UI/shop/shop_rewiew.dart';
import 'package:login/models/AuthModel.dart';
import 'package:login/repos/AuthRepus.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  get hintText => null;
  bool IsAdmin = false;
  bool Iscreate = false;
  AuthModel model = AuthModel();
  var dio = Dio();
  AuthRepository logrepos = AuthRepository();
  @override
  Widget build(BuildContext context) {
    var blocblocAuth = AuthBlocBloc(AuthInitial(), model, logrepos, dio);
    IsAdmin = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Center(child: Image.asset('assets/images/sparks.png')),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    const Text(
                      'Войти',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                    const SizedBox(height: 150),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          List<int> bytes = utf8.encode(
                              value); // Преобразование текста в байтовый массив
                          Digest digest = sha256.convert(bytes);
                          String hashedText =
                              digest.toString(); // Преобразование хеша в строку
                          model?.login = value;
                          if (value == 'Timaga') {
                            IsAdmin = true;
                          }
                          print(hashedText);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(27),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Pallete.borderColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Pallete.gradient2,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Login",
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          List<int> bytes = utf8.encode(
                              value); // Преобразование текста в байтовый массив
                          Digest digest = sha256.convert(bytes);
                          String hashedText =
                              digest.toString(); // Преобразование хеша в строку
                          model?.password = hashedText;
                          print(hashedText);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(27),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Pallete.borderColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Pallete.gradient2,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocListener<AuthBlocBloc, AuthBlocState>(
                        bloc: blocblocAuth,
                        child: Container(),
                        listener: (context, state) {
                          if (state is AuthLoginLoaded) {
                            Iscreate = false;
                            if (IsAdmin == false) {
                              context.pushReplacement("/shop_rewiew");
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShopRewiew(
                                        Isadmin: IsAdmin,
                                      )));
                            }
                          } else if (state is AuthLoadingFailure) {
                            setState(() {
                              Iscreate = true;
                            });
                          }
                        }),
                    if (Iscreate == true)
                      Text(
                        "Неверный логин или пароль",
                        style: GoogleFonts.roboto(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    GradientButton(
                      label: "Войти",
                      onTap: () {
                        blocblocAuth.add(AuthLoginEvent());
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Нет аккаунта?  ',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Регистрация',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/');
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       context.go('/frgpsw');
                    //     },
                    //     child: Text(
                    //       "Забыли пароль?",
                    //       style: TextStyle(fontSize: 16, color: Colors.grey),
                    //     ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
