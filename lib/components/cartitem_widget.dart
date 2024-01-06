import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cartbloc/cart_cubit.dart';
import '../models/cartItem_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              item.image,
              width: 80,
              scale: 2.0,
            ),
          ),
          Expanded(
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(item.name),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<CartCubit>(context).decrementItemQuantity(item);
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(item.quantity.toString()),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<CartCubit>(context).incrementItemQuantity(item);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<CartCubit>(context).removeItemFromCart(item);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              '\$${item.price}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
