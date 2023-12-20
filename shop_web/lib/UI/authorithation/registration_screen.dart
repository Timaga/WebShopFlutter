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
import 'package:login/UI/authorithation/reg_verification_screen.dart';
import 'package:login/UI/design/gradient_button.dart';
import 'package:login/UI/design/login_field.dart';
import 'package:login/UI/design/palette.dart';
import 'package:login/models/AuthModel.dart';
import 'package:login/repos/AuthRepus.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool Iscreare = false;
  AuthModel model = AuthModel();
  var dio = Dio();
  AuthRepository logrepos = AuthRepository();
  @override
  Widget build(BuildContext context) {
    var blocblocAuth = AuthBlocBloc(AuthInitial(), model, logrepos, dio);
    String a;

    return Scaffold(
      body: SingleChildScrollView(
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
                    'Регистрация',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  const SizedBox(height: 100),
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
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  // LoginField(
                  //   hintText: 'Email',
                  // ),
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
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (Iscreare == true)
                    Text(
                      "Логин уже существует",
                      style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  const SizedBox(height: 20),
                  GradientButton(
                    label: "Зарегестрироваться",
                    onTap: () {
                      blocblocAuth.add(AuthEvent());
                    },
                  ),
                  BlocListener<AuthBlocBloc, AuthBlocState>(
                      bloc: blocblocAuth,
                      child: Container(),
                      listener: (context, state) {
                        if (state is AuthLoaded) {
                          Iscreare = false;
                          context.pushReplacement("/shop_rewiew");
                        } else if (state is AuthLoadingFailure) {
                          setState(() {
                            Iscreare = true;
                          });
                        }
                      }),

                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Уже есть аккаунт?  ',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Войти',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/login');
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
