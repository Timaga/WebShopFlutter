import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/BloC/LogBloc/Log/index.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/repos/logRepos.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   List<Widget> logy=[];
  @override
  Widget build(BuildContext context) {
    var dio = Dio();
    LogModel log = LogModel();
    LogRepository logrepos = LogRepository();
    var blocblocLogs = LogBloc(LogInitial(), logrepos, log, dio);
    blocblocLogs.add(GetLogEvent());

    return SingleChildScrollView(
      child: BlocBuilder<LogBloc, LogState>(
        bloc: blocblocLogs,
        builder: (context, state) {
          if (state is ListLogLoaded) {
            for (LogModel element in state.log) {
              logy.add(TextLog(
                  ip: element.ip!,
                  data: element.date!,
                  id: element.id!,
                  message: element.message!,
                  route: element.route!));
            }
            return Column(
              children: [
                ...logy,
              ],
            );
          }
          if (state is LogLoadingFailure) {
            return Center(
              child: Text("state.error"),
            );
          }
          if (state is LogLoading) {
              return Center(
              child: Text("state.error"),
            );
          }
          
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TextLog extends StatefulWidget {
 int id;
  String ip;
  String data;
  String message;
  String route;
  TextLog(
      {super.key,
      required this.ip,
      required this.data,
      required this.id,
      required this.message,
      required this.route});

  @override
  State<TextLog> createState() => _TextLogState();
}

class _TextLogState extends State<TextLog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${widget.id}"),
        Text("${widget.message}"),
        Text("${widget.ip}"),
        Text("${widget.data}"),
        Text("${widget.route}"),
      ],
    );
  }
}
