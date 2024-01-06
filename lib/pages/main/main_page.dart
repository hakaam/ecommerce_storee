import 'package:ecommerce_store/components/category_widget.dart';
import 'package:ecommerce_store/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/products_bloc/products_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 1,
                child: SizedBox(
                  height: height * 0.1,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search Product',
                        contentPadding: EdgeInsets.symmetric(horizontal: 15)),

                    controller: _searchController, // Use _searchController here
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });

                      BlocProvider.of<ProductCubit>(context)
                          .searchProducts(searchQuery);
                    },
                    // ... other properties
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CategoryWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ProductWidget()
            ],
          ),
        ),
      ),
    );
  }
}
