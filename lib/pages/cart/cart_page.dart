import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cartbloc/cart_cubit.dart';
import '../../bloc/cartbloc/cart_states.dart';
import '../../components/cartitem_widget.dart';
import '../../models/cartItem_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> cartItemsFuture;

  @override
  void initState() {
    super.initState();
    refreshCartItems(); // Load cart items initially
  }

  // Method to refresh cart items
  Future<void> refreshCartItems() async {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    setState(() {
      cartItemsFuture = cartCubit.fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              cartCubit.clearCart();
              refreshCartItems();
            },
            child: const Text(
              'Clear Cart',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        // ... (other app bar properties)
      ),


      body: StreamBuilder<List<CartItem>>(
        stream: cartCubit.cartItemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading cart'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items in the cart.'));
          } else {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10
              ),
              children: (snapshot.data! as List<CartItem>)
                  .map((item) => CartItemWidget(item: item))
                  .toList(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10

        ),
        color: Colors.lightGreenAccent,
        child:Container(
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartUpdated) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' \$${state.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ],
                );
              }
              return Container();
            },
          ),
        ),

      ),
    );

  }

}
