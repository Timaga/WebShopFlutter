import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:login/BloC/AuthBloc/index.dart';
import 'package:login/models/AuthModel.dart';

import '../../repos/AuthRepus.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository _authrepos;
  final AuthModel _authmodel;
  final Dio dio;
  AuthBlocBloc(
      AuthBlocState initialState, this._authmodel, this._authrepos, this.dio)
      : super(initialState) {
    on<AuthEvent>((event, emit) async {
      try {
        if (state is! AuthLoaded) {
          emit(AuthLoading());
        }
        final response = await _authrepos.sendLog(
            _authmodel.password!, _authmodel.login!, dio);
        emit(AuthLoaded(auth: response));
      } catch (e) {
        emit(AuthLoadingFailure(exception: e));
      }
    });
     on<AuthLoginEvent>((event, emit) async {
      try {
        if (state is! AuthLoginLoaded) {
          emit(AuthLoading());
        }
        final response = await _authrepos.sendLogAuth(
            _authmodel.password!, _authmodel.login!, dio);
        emit(AuthLoginLoaded(auth: response));
      } catch (e) {
        emit(AuthLoadingFailure(exception: e));
      }
    });
  }
}
