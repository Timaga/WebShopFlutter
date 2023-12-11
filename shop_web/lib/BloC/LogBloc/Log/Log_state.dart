
import 'package:login/models/LogModel.dart';

abstract class LogState {
  LogState();

  @override
  List<Object?> get props => [];
}

/// UnInitialized
class LogInitial extends LogState {
  LogInitial();
  @override
  List<Object?> get props => [];
}

class LogLoading extends LogState {
  @override
  List<Object?> get props => [];
}

class LogLoaded extends LogState {
  LogLoaded({
    required this.log,
  });

  final String log;
}
class ListLogLoaded extends LogState {
  ListLogLoaded({
    required this.log,
  });

  final List<LogModel> log;
}

class LogLoadingFailure extends LogState {
  LogLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
