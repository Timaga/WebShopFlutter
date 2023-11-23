import 'package:go_router/go_router.dart';
import 'package:login/UI/authorithation/forget_password_verification.dart';
import 'package:login/UI/design/gradient_button.dart';
import 'package:login/UI/design/login_field.dart';

import 'registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Center(child: Image.asset('assets/images/sparks.png')),
          Center(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Center(
                                child: Text(
                                  'Забыли пароль?',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.black54,
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  'Введите адрес электронной почты, связанный с вашей учетной записью.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.black54,
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  'Мы отправим вам по электронной почте код подтверждения, чтобы проверить вашу подлинность.',
                                  style: TextStyle(
                                    // color: Colors.black38,
                                    fontSize: 16,
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              LoginField(hintText: 'Email'),
                              SizedBox(height: 40.0),
                              GradientButton(
                                label: "Дальше",
                                onTap: () {
                                  context
                                      .pushReplacement("/frgpsw/verification");
                                },
                              ),
                              SizedBox(height: 30.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Вспомнили код? ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Войти',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.go('/login');
                                        },
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
