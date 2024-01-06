import 'package:ecommerce_store/components/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cartbloc/cart_cubit.dart';
import '../bloc/cartbloc/cart_states.dart';
import '../bloc/location_bloc/location_cubit.dart';
import '../bloc/products_bloc/products_cubit.dart';
import '../bloc/products_bloc/products_states.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductLoadSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemCount: state.products.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Padding(
                padding: EdgeInsets.all(2),
                child: GestureDetector(
                  onTap: () {
                    if (product != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: product,
                            locationCubit:
                                BlocProvider.of<LocationCubit>(context),
                          ),
                        ),
                      );
                    } else {
                      print('Tapped product is null');
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: BlocListener<CartCubit, CartState>(
                              listener: (context, cartState) {
                                if (cartState is CartLoadFailure) {
                                  print(
                                      'Error loading cart: ${cartState.error}');
                                } else if (cartState is CartUpdated) {
                                  // Handle cart update if needed
                                }
                              },
                              child: IconButton(
                                onPressed: () {
                                  if (product != null &&
                                      product.image != null) {
                                    print('Adding item to cart: $product');

                                    BlocProvider.of<CartCubit>(context)
                                        .addItemToCart(product);
                                  } else {
                                    print('Product or its image is null');
                                  }
                                },
                                icon: Icon(Icons.shopping_bag_outlined),
                              ),
                            ),
                          ),
                          if (product != null && product.image != null)
                            Image.network(
                              product.image,
                              fit: BoxFit.fitHeight,
                              height: 140,
                            ),
                          if (product != null && product.name != null)
                            Center(
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue),
                                ),
                                Text(
                                  '\$${product.oldPrice}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          // ... (previous code)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is ProductLoadFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
