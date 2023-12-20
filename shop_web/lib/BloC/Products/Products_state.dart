import 'package:equatable/equatable.dart';
import 'package:login/models/Products.dart';

abstract class ProductsState extends Equatable {
  ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  ProductsInitial();
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsLoaded extends ProductsState {
  ProductsLoaded({
    required this.product,
  });

  final String product;
}
class ListProductsLoaded extends ProductsState {
  ListProductsLoaded({
    required this.products,
  });

  final List<ProductsModel> products;
}

class ProductsLoadingFailure extends ProductsState {
  ProductsLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}