import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:login/BloC/Orders/index.dart';
import 'package:login/models/orderModel.dart';
import 'package:login/repos/orderRepos.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderrepos;
  final OrderModel _ordermodel;
  final Dio dio;
  OrdersBloc(
      OrdersState initialState, this._ordermodel, this._orderrepos, this.dio)
      : super(initialState) {
    on<OrderAddEvent>((event, emit) async {
      try {
        if (state is! OrderLoaded) {
          emit(OrderLoading());
        }
        final response = await _orderrepos.sendOrder(
            dio, _ordermodel.customer_id!, _ordermodel.product_id!);
        emit(OrderLoaded(log: response));
      } catch (e) {
        emit(OrderLoadingFailure(exception: e));
      }
    });
    on<OrderSelectEvent>((event, emit) async {
      try {
        if (state is! OrderListLoaded) {
          emit(OrderLoading());
        }
        final response = await _orderrepos.getOrders(_ordermodel.customer_id!);
        emit(OrderListLoaded(order: response));
      } catch (e) {
        emit(OrderLoadingFailure(exception: e));
      }
    });
  }
}
