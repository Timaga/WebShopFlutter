// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/UI/design/palette.dart';
import 'package:login/router.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  FlutterError.onError =
      (details) => talker.handle(details.exception, details.stack);
  runZonedGuarded(
      () => runApp(MyApp(
            talker: talker,
          )), (error, stack) {
    talker.handle(error, stack);
  });
}

class MyApp extends StatelessWidget {
  Talker talker;
  MyApp({super.key, required this.talker});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      routerConfig: AppRouter().router,
    );
  }
}
