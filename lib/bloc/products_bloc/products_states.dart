
import 'package:ecommerce_store/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<ProductModel> products;

  ProductLoadSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductLoadFailure extends ProductState {
  final String error;

  ProductLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
