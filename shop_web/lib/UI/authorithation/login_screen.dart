import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/UI/authorithation/forget_password.dart';
import 'package:login/UI/authorithation/registration_screen.dart';
import 'package:login/UI/authorithation/reg_verification_screen.dart';
import 'package:login/UI/design/gradient_button.dart';
import 'package:login/UI/design/login_field.dart';

import 'package:login/UI/design/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Войти',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 150),
              LoginField(hintText: 'Email'),
              const SizedBox(height: 15),
              LoginField(hintText: 'Password'),
              const SizedBox(height: 20),
               GradientButton(
                label: "Войти",
                onTap: (){},
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
              TextButton(
                  onPressed: () {
                    context.go('/frgpsw');
                  },
                  child: Text(
                    "Забыли пароль?",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
