import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String image;

  Category({required this.name, required this.image});

  @override
  List<Object?> get props => [name, image];
}