import 'package:ecommerce_store/components/product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/categories_bloc/category_cubit.dart';
import '../bloc/categories_bloc/category_states.dart';
import '../models/categories_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoadSuccess) {
          return buildCategoriesList(context, state.categories);
        } else if (state is CategoryLoadFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }

  Widget buildCategoriesList(BuildContext context, List<Category> categories) {
    return Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductByCategoryScreen(
                      categoryName: category.name,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(category.image, scale: 8),
                    radius: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    category.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
