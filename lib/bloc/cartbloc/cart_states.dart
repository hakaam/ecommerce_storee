


import 'package:equatable/equatable.dart';

import '../../models/cartItem_model.dart';
import '../../models/product_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  CartLoaded(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartUpdated extends CartState {
  final List<CartItem> cartItems;
  final double totalPrice; // Make sure totalPrice is defined

  CartUpdated({required this.cartItems, required this.totalPrice});

  @override
  List<Object> get props => [cartItems, totalPrice];
}



class CartLoadFailure extends CartState {
  final String error;

  const CartLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
