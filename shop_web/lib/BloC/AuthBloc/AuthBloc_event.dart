import 'dart:async';
import 'dart:developer' as developer;

import 'package:login/BloC/AuthBloc/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthBlocEvent {
 
}

class AuthEvent extends AuthBlocEvent {
  AuthEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
