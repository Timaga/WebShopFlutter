import 'dart:async';
import 'dart:developer' as developer;

import 'package:login/BloC/LogBloc/Log/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogEvent {}

class LoadLogEvent extends LogEvent {
  LoadLogEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
