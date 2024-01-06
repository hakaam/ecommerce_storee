import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String productId;
  final String name;
  final String image;
  final double price;
  final double? oldPrice;
  final bool? isAvailable;
  final String description;
  final String? categoryName;

  ProductModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice,
    this.isAvailable,
    required this.description,
    this.categoryName,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: _parseDouble(map['price']) ?? 0.0,
      oldPrice: _parseDouble(map['oldPrice']),
      isAvailable: map['isAvailable'],
      description: map['description'] ?? '',
      categoryName: map['categoryName'],
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  @override
  List<Object?> get props {
    return [
      productId,
      name,
      image,
      price,
      oldPrice,
      isAvailable,
      description,
      categoryName,
    ];
  }
}
