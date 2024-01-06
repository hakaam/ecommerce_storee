import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/categories_model.dart';
import '../../services/category_service.dart';
import 'category_states.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());
      final List<Map<String, dynamic>> categoryData = await CategoryService.fetchCategories();
      final List<Category> categories = categoryData
          .map((category) => Category(name: category['name'], image: category['image']))
          .toList();
      emit(CategoryLoadSuccess(categories));
    } catch (e) {
      emit(CategoryLoadFailure('Error fetching categories: $e'));
    }
  }
}
