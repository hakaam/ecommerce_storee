import 'package:ecommerce_store/bloc/bottom_navigation_bar_bloc/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_navigation_bar_bloc/bottom_navgation_states.dart';
import '../cart/cart_page.dart';
import '../favorite/favorite_page.dart';
import '../main/main_page.dart';
import '../profile/profile_page.dart';

class BottomNavigationBarPage extends StatelessWidget {
  final List<Widget> pages = [
    MainPage(),
    FavoritePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        final selectedIndex = state?.selectedIndex ?? 0; // Use a default value if state is null
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            currentIndex: selectedIndex,
            onTap: (index) =>
                context.read<BottomNavigationCubit>().onItemTap(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.blue,
                  size: 30,
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.blue,
                  size: 30,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 30,
                ),
                label: 'Profile',
              ),
            ],
          ),
          body: pages[selectedIndex],
        );
      },
    );
  }
}


