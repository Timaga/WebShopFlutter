import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class PlusCenterWidget extends StatefulWidget {
  final Function OnPressed;
  final bool dash;
  const PlusCenterWidget(
      {super.key, required this.OnPressed, this.dash = true});

  @override
  State<PlusCenterWidget> createState() => _PlusCenterWidgetState();
}

class _PlusCenterWidgetState extends State<PlusCenterWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.dash
        ? Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: DashedBorder.fromBorderSide(
                        dashLength: 20,
                        side: BorderSide(color: Colors.black, width: 5)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Container(
                      height: 440.0,
                      width: 80,
                      child: ClipOval(
                        child: IconButton(
                          icon: Icon(
                            BoxIcons.bx_plus,
                            size: 64,
                          ),
                          onPressed: () async {
                            widget.OnPressed();
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1.0,
                                spreadRadius: 1.0)
                          ])),
                ),
              ),
            ),
          )
        : Container(
            child: Container(
              height: 64.0,
              width: 64,
              child: ClipOval(
                child: IconButton(
                  icon: Icon(
                    BoxIcons.bx_plus,
                    size: 32,
                  ),
                  onPressed: () {
                    widget.OnPressed();
                  },
                ),
              ),
            ),
          );
  }
}