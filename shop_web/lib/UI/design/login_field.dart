import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:login/UI/design/palette.dart';

class LoginField extends StatelessWidget {
  final String hintText;

  final bool IsHash;
  const LoginField({
    Key? key,
    required this.hintText,
    this.IsHash = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      child: TextFormField(
        onChanged: (value) {
          List<int> bytes =utf8.encode(value); // Преобразование текста в байтовый массив
          Digest digest = sha256.convert(bytes);
          String hashedText = digest.toString(); // Преобразование хеша в строку

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
          hintText: hintText,
        ),
      ),
    );
  }
}
