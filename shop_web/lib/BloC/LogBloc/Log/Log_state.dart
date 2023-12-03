import 'package:equatable/equatable.dart';
import 'package:login/models/LogModel.dart';

abstract class LogState extends Equatable {
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

class LogLoadingFailure extends LogState {
  LogLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
