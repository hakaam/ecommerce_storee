import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cartItem_model.dart';
import '../models/product_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  Future<void> addItemToCart(ProductModel product) async {
    if (product.productId != null &&
        product.name != null &&
        product.image != null) {
      CartItem cartItem = CartItem(
        id: product.productId!,
        name: product.name!,
        price: product.price ?? 0.0,
        quantity: 1,
        image: product.image!,
      );

      _cartItems.add(cartItem);

      print('Cart items after adding: $_cartItems');
    }
  }

  Future<List<CartItem>> fetchCartItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('cartItems').get();

      List<CartItem> cartItems = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()!;
        return CartItem(
          id: data['productId'],
          name: data['name'],
          price: data['price'].toDouble(),
          quantity: data['quantity'],
          image: data['image'],
        );
      }).toList();

      return _cartItems;
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  void incrementItemQuantity(CartItem cartItem) {
    cartItem.quantity++;
  }

  void decrementItemQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    }
  }

  void removeItemFromCart(ProductModel product) {
    if (product.productId != null) {
      _cartItems.removeWhere((item) => item.id == product.productId);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}
