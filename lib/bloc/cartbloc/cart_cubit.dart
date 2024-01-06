import 'package:bloc/bloc.dart';
import 'package:ecommerce_store/models/product_model.dart';
import 'package:ecommerce_store/services/cart_service.dart';

import '../../models/cartItem_model.dart';
import 'cart_states.dart';
import 'dart:async';

class CartCubit extends Cubit<CartState> {
  final CartService cartService;
  List<CartItem> _cartItems = []; // Add this line to declare cartService

  final _cartItemsController = StreamController<List<CartItem>>.broadcast();

  Stream<List<CartItem>> get cartItemsStream => _cartItemsController.stream;

  CartCubit(this.cartService) : super(CartInitial());

  List<CartItem> get cartItems => _cartItems;

  Future<void> addItemToCart(ProductModel product) async {
    try {
      if (product != null &&
          product.productId != null &&
          product.name != null &&
          product.image != null) {
        CartItem existingItem = _cartItems.firstWhere(
              (item) => item.id == product.productId,
          orElse: () =>
              CartItem(
                id: '',
                name: '',
                price: 0.0,
                quantity: 0,
                image: '',
              ),
        );

        if (existingItem.id.isNotEmpty) {
          existingItem.quantity++;
        } else {
          CartItem cartItem = CartItem(
            id: product.productId!,
            name: product.name!,
            price: product.price ?? 0.0,
            quantity: 1,
            image: product.image!,
          );

          _cartItems.add(cartItem);
        }

        double totalPrice = calculateTotalPrice(); // Calculate or get the total price

        emit(CartUpdated(cartItems: _cartItems.toList(),
            totalPrice: totalPrice)); // Ensure state is updated
        _cartItemsController.add(_cartItems.toList()); // Add to stream

        print('Cart items after adding: $_cartItems');
      } else {
        emit(CartLoadFailure('Error: Product or its properties are null'));
      }
    } catch (e) {
      emit(CartLoadFailure('Error adding item to cart: $e'));
    }
  }


  void incrementItemQuantity(CartItem cartItem) {
    cartItem.quantity++;
    double totalPrice = calculateTotalPrice(); // Calculate or get the total price
    emit(CartUpdated(cartItems: _cartItems.toList(), totalPrice: totalPrice));
    _cartItemsController.add(_cartItems.toList()); // Add to stream
    print('Item quantity increment: ${cartItem.quantity}');
  }


  void decrementItemQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    }

    double totalPrice = calculateTotalPrice(); // Calculate or get the total price

    emit(CartUpdated(cartItems: _cartItems.toList(), totalPrice: totalPrice));
    _cartItemsController.add(_cartItems.toList()); // Add to stream

    print('Item quantity decremented: ${cartItem.quantity}');
  }


  void removeItemFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    double totalPrice = calculateTotalPrice(); // Calculate total price
    emit(CartUpdated(cartItems: List.from(_cartItems), totalPrice: totalPrice));
    _cartItemsController.add(_cartItems.toList()); // Add to stream
    print('Item removed from cart. New cart items: $_cartItems');
  }

  void clearCart() {
    _cartItems.clear();
    double totalPrice = 0.0; // Set to the default value or calculate it if needed
    emit(CartUpdated(cartItems: List.from(_cartItems), totalPrice: totalPrice));
    _cartItemsController.add(_cartItems.toList()); // Add to stream
    print('Cart cleared. New cart items: $_cartItems');
  }

  Future<List<CartItem>> fetchCartItems() async {
    try {
      final List<CartItem> cartItems = await cartService.fetchCartItems();
      _cartItems = cartItems;
      emit(CartLoaded(cartItems));
      _cartItemsController.add(_cartItems.toList()); // Add to stream
      return cartItems;
    } catch (e) {
      emit(CartLoadFailure('Error loading cart: $e'));
      return [];
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (CartItem item in _cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }
}