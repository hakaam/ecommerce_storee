import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService{
  static Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();

      return querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return doc.data()!;
      }).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

}
