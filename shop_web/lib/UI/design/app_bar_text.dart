import 'package:flutter/material.dart';

class AppBarText extends StatefulWidget {
  final Color ChangedColor;
  Function onPressed;
  final String title;
AppBarText(
      {super.key, required this.ChangedColor, required this.title,required this.onPressed});

  @override
  State<AppBarText> createState() => _AppBarTextState();
}

class _AppBarTextState extends State<AppBarText> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextButton(
      onPressed: () {
        widget.onPressed();

      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return widget.ChangedColor; // Цвет текста при наведении
            }
            return Colors.white; // Цвет текста по умолчанию
          },
        ),
      ),
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ));
  }
}
