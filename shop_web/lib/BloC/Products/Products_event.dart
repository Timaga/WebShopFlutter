import 'dart:async';
import 'dart:developer' as developer;

import 'package:login/BloC/Products/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductsEvent {}

class LoadProductsEvent extends ProductsEvent {
  LoadProductsEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class LoadListProductsEvent extends ProductsEvent {
  LoadListProductsEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class LoadListProductsByIdEvent extends ProductsEvent {
  LoadListProductsByIdEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

