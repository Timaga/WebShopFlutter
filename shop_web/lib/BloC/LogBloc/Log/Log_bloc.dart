import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:login/BloC/LogBloc/Log/index.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/repos/logRepos.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final LogRepository _logrepos;
  final LogModel _logmodel;
  final Dio dio;
  LogBloc(LogState initialState, this._logrepos, this._logmodel, this.dio)
      : super(initialState) {
    on<GetLogEvent>((event, emit) async {
      try {
        if (state is! LogLoaded) {
          emit(LogLoading());
        }
        final response = await _logrepos.getLogs();
        emit(ListLogLoaded(log: response));
      } catch (e) {
        emit(LogLoadingFailure(exception: e));
      }
    });
    on<LogEvent>((event, emit) async {
      try {
        if (state is! LogLoaded) {
          emit(LogLoading());
        }
        final response = await _logrepos.sendLog(
            _logmodel.message!, _logmodel.ip!, dio, _logmodel.route!);
        emit(LogLoaded(log: response));
      } catch (e) {
        emit(LogLoadingFailure(exception: e));
      }
    });
  }
}
