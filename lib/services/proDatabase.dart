import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/prod.dart';

class ProductDatabase {

  final CollectionReference productCollection = Firestore.instance.collection('product');

  Future updateProductData(String category, String brand, String name, String discountPrice, String quantity, String description, String rating, String actualPrice) async {
    return await productCollection.document().setData({
      "category" : category,
      "brand" : brand,
      "name" : name,
      "actualPrice": actualPrice,
      "quantity" : quantity,
      "description" : description,
      "rating" : rating,
      "discountPrice" : discountPrice,
    });
  }
}