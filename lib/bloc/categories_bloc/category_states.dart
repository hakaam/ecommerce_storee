import 'package:equatable/equatable.dart';
import '../../models/categories_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<Category> categories;

  CategoryLoadSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryLoadFailure extends CategoryState {
  final String error;

  CategoryLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
