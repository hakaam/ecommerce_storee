import 'package:ecommerce_store/bloc/location_bloc/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/authbloc/auth_cubit.dart';
import 'bloc/authbloc/auth_states.dart';
import 'bloc/bottom_navigation_bar_bloc/bottom_navigation_cubit.dart';
import 'bloc/cartbloc/cart_cubit.dart';
import 'bloc/categories_bloc/category_cubit.dart';
import 'bloc/products_bloc/products_cubit.dart';
import 'pages/signin/signin_screen.dart';
import 'pages/home/home_page.dart';
import 'services/cart_service.dart';
import 'services/products_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final CartService cartService = CartService();

  runApp(MyApp(cartService: cartService));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.cartService}) : super(key: key);
  final CartService cartService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationCubit>(
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit()..fetchCategories(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(cartService)..fetchCartItems(),
        ),
        BlocProvider<ProductCubit>(
          create: (context) {
            final cartCubit = BlocProvider.of<CartCubit>(context);
            return ProductCubit(ProductService(), cartCubit)..fetchProducts();
          },
        ),
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.amber),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is AuthAuthenticated
                ? BottomNavigationBarPage()
                :  SignInScreen();

          },
        ),
      ),
    );
  }
}
