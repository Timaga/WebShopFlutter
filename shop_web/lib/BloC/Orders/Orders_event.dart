import 'dart:async';
import 'dart:developer' as developer;

import 'package:login/BloC/Orders/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OrdersEvent {

}

class OrderAddEvent extends OrdersEvent {
  OrderAddEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class OrderSelectEvent extends OrdersEvent {
  OrderSelectEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

