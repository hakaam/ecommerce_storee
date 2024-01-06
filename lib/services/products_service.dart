import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('products').get();

      return querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return doc.data()!;
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
  Future<List<ProductModel>> fetchProductsByCategory(String categoryName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('products')
          .where('categoryName', isEqualTo: categoryName)
          .get();

      final List<ProductModel> products = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data()!);
      }).toList();

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection('products').get();

      final List<Map<String, dynamic>> products = querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return doc.data()!;
      }).toList();

      final List<Map<String, dynamic>> filteredProducts =
      products.where((product) {
        final String productName = product['name'].toString().toLowerCase();
        return productName.contains(query.toLowerCase());
      }).toList();

      return filteredProducts;
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }
}
