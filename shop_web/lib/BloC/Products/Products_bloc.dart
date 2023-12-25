import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:login/BloC/Products/index.dart';
import 'package:login/models/Products.dart';
import 'package:login/repos/ProductRepos.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productrepos;
  final ProductsModel _productmodel;
  final Dio dio;
  ProductsBloc(ProductsState initialState, this._productmodel,
      this._productrepos, this.dio)
      : super(initialState) {
    on<LoadListProductsEvent>((event, emit) async {
      try {
        if (state is! ListProductsLoaded) {
          emit(ProductsLoading());
        }
        final response = await _productrepos.getProducts();
        emit(ListProductsLoaded(products: response));
      } catch (e) {
        emit(ProductsLoadingFailure(exception: e));
      }
    });
    on<LoadProductsEvent>((event, emit) async {
      try {
        if (state is! ProductsLoaded) {
          emit(ProductsLoading());
        }

        final response = await _productrepos.sendProduct(
            _productmodel.title!,
            _productmodel.price!,
            dio,
            _productmodel.file!,
            _productmodel.category!);
        emit(ProductsLoaded(product: response));
      } catch (e) {
        emit(ProductsLoadingFailure(exception: e));
      }
    });
  }
}
