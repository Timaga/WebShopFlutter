import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login/UI/authorithation/registration_screen.dart';
import 'package:login/UI/design/Theme_helper.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() =>
      _VerificationScreenState();
}

class _VerificationScreenState
    extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/signin_balls_4.png'),
          SafeArea(
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Подтверждение',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Введите код подтверждения, который мы только что отправили вам на ваш адрес электронной почты.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black54,
                            ),
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
                        OTPTextField(
                          length: 4,
                          width: 300,
                          fieldWidth: 50,
                          style: TextStyle(fontSize: 30),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          otpFieldStyle: OtpFieldStyle(
                              borderColor: Colors.white,
                              focusBorderColor: Colors.white,
                              disabledBorderColor: Colors.white,
                              enabledBorderColor: Colors.white),
                          onChanged: (pin) {
                            setState(() {
                              if (pin.length == 4) _pinSuccess = true;
                              if (pin.length < 4) _pinSuccess = false;
                            });
                          },
                        ),
                        SizedBox(height: 50.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Если вы не получили код!",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              TextSpan(
                                text: "  ",
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: 'Отправить заного',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                            "Успешно",
                                            "Повторная отправка кода подтверждения прошла успешно.",
                                            context);
                                      },
                                    );
                                  },
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        
                        // Container(
                        //   child: GlowingButton(
                        //     onTap: _pinSuccess
                        //         ? () {
                        //             Navigator.of(context).pushAndRemoveUntil(
                        //                 MaterialPageRoute(
                        //                     builder: (context) =>
                        //                         ProfileScreen()),
                        //                 (Route<dynamic> route) => false);
                        //           }
                        //         : null,
                        //     label: "Подтвердить",
                        //     color1: _pinSuccess
                        //         ? Colors.greenAccent
                        //         : Colors.black38,
                        //     color2: _pinSuccess ? Colors.cyan : Colors.black38,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
