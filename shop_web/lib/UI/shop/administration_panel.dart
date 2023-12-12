import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/BloC/LogBloc/Log/index.dart';
import 'package:login/UI/design/app_bar_text.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/repos/logRepos.dart';
import 'package:lottie/lottie.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Widget> logy = [];
  Set<String> routes = {};
  bool logsOnPerssed = true;
  bool isRoute = false;
  String selectedRoute = '/verification';
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
            logy.clear();
            routes.clear();
            if (logsOnPerssed == true && isRoute == false) {
              for (LogModel element in state.log.reversed) {
                logy.add(TextLog(
                    ip: element.ip!,
                    data: element.date!,
                    id: element.id!,
                    message: element.message!,
                    route: element.route!));
                routes.add(element.route!);
              }
            } else if (isRoute == false) {
              for (LogModel element in state.log) {
                logy.add(TextLog(
                    ip: element.ip!,
                    data: element.date!,
                    id: element.id!,
                    message: element.message!,
                    route: element.route!));
                routes.add(element.route!);
              }
            }
            if (isRoute == true) {
              for (LogModel element in state.log.reversed) {
                if (element.route == selectedRoute) {
                  logy.add(TextLog(
                      ip: element.ip!,
                      data: element.date!,
                      id: element.id!,
                      message: element.message!,
                      route: element.route!));
                }
                routes.add(element.route!);
              }
            }
            return Column(
              children: [
                Row(
                  children: [
                    AppBarText(
                      ChangedColor: Colors.blueGrey,
                      title: "Сортировать по убыванию",
                      onPressed: () {
                        setState(() {
                          logsOnPerssed = true;
                          isRoute = false;
                        });
                      },
                    ),
                    AppBarText(
                      ChangedColor: Colors.greenAccent,
                      title: "Сортировать по возрастанию",
                      onPressed: () {
                        setState(() {
                          logsOnPerssed = false;
                          isRoute = false;
                        });
                      },
                    ),
                    AppBarText(
                      ChangedColor: Colors.greenAccent,
                      title: "Сортировать по route",
                      onPressed: () {
                        setState(() {
                          isRoute = true;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                if (isRoute == true)
                  DropdownButton<String>(
                    value: selectedRoute,
                    items: routes.map((String route) {
                      return DropdownMenuItem<String>(
                        value: route,
                        child: Text(route),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRoute = newValue!;
                      });
                    },
                  ),
                ...logy,
              ],
            );
          }
          if (state is LogLoadingFailure) {
            return Center(
              
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Lottie.asset(
                    'assets/jsons/flame_cute_man.json',
                    width:300,
                    height: 300,
                  ),
                ],
              ),
            );
          }
          if (state is LogLoading) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Lottie.asset(
                    'assets/jsons/flame_cute_man.json',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "id Лога: ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.id}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Cообщение Лога: ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.message}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Айпи : ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.ip}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Дата записи лога : ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.data}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Маршрут страницы: ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${widget.route}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
