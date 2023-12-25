import 'package:equatable/equatable.dart';
import 'package:login/models/orderModel.dart';

abstract class OrdersState extends Equatable {
  OrdersState();

  @override
  List<Object?> get props => [];
}

/// UnInitialized
class OrderInitial extends OrdersState {
  OrderInitial();
  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrdersState {
  @override
  List<Object?> get props => [];
}

class OrderLoaded extends OrdersState {
  OrderLoaded({
    required this.log,
  });

  final String log;
}

class OrderListLoaded extends OrdersState {
  OrderListLoaded({
    required this.order,
  });

  final List<OrderModel> order;
}

class OrderLoadingFailure extends OrdersState {
  OrderLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
