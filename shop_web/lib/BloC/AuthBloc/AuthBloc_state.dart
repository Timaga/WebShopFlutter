import 'package:equatable/equatable.dart';

abstract class AuthBlocState extends Equatable {
  AuthBlocState();

  @override
  List<Object?> get props => [];
}

/// UnInitialized
class AuthInitial extends AuthBlocState {
  AuthInitial();
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthBlocState {
  @override
  List<Object?> get props => [];
}

class AuthLoaded extends AuthBlocState {
  AuthLoaded({
    required this.auth,
  });

  final String auth;
}


class AuthLoadingFailure extends AuthBlocState {
  AuthLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
