// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/BloC/LogBloc/Log/index.dart';
import 'package:login/UI/design/palette.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/repos/logRepos.dart';
import 'package:login/router.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  LogModel log = LogModel();

  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
          printRequestData: true,
          printRequestHeaders: true,
          printResponseData: true,
          printResponseHeaders: true,
          printResponseMessage: true)));
  LogRepository logrepos = LogRepository();
  var LogBlocBloc = LogBloc(LogInitial(), logrepos, log, dio);
  final talker = TalkerFlutter.init();
  FlutterError.onError = (details) async {
    talker.handle(details.exception, details.stack);
    log.message = details.exception.toString();
    final ipv4 = await Ipify.ipv4();
    log.ip = ipv4;
    print(log.route);
    // LogBlocBloc.add(LoadLogEvent());
  };
  runZonedGuarded(
      () => runApp(MyApp(
            talker: talker,
            log: log,
          )), (error, stack) async {
    talker.handle(error, stack);
    log.message = error.toString();
    final ipv4 = await Ipify.ipv4();
    log.ip = ipv4;
    // LogBlocBloc.add(LoadLogEvent());
  });
}

class MyApp extends StatelessWidget {
  Talker talker;
  LogModel log;
  MyApp({super.key, required this.talker,required this.log});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      routerConfig: NyAppRouter.returnRouter(true,talker,log),
    );
  }
}
