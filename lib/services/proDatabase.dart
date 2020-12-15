import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/prod.dart';

class ProductDatabase {

  final CollectionReference productCollection = Firestore.instance.collection('product');

  Future updateProductData(String pid, String category, String subcategory, String brand, String name, String discountPrice, String quantity, String description, String rating, String actualPrice, String productPic) async {
    return await productCollection.document(pid).setData({
      "category" : category,
      "subcategory" : subcategory,
      "brand" : brand,
      "name" : name,
      "actualPrice": actualPrice,
      "quantity" : quantity,
      "description" : description,
      "rating" : rating,
      "discountPrice" : discountPrice,
      "productPic" : productPic
    });
  }

  Prod prodDataFromSnapshot(DocumentSnapshot snapshot) {
    return Prod(
      pid : snapshot.documentID,
      category: snapshot.data['category'],
      subcategory: snapshot.data['subcategory'],
      brand: snapshot.data['brand'],
      name: snapshot.data['name'],
      actualPrice: snapshot.data['actualPrice'],
      discountPrice: snapshot.data['discountPrice'],
      quantity: snapshot.data['quantity'],
      rating: snapshot.data['rating'],
      description: snapshot.data['description'],
      productPic: snapshot.data['productPic']
    );
  }
}
