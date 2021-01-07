import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/prod.dart';

class ProductDatabase {

  final String pid;

  ProductDatabase({ this.pid });


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


  Prod _prodDataFromSnapshot(DocumentSnapshot snapshot) {
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

  // get user doc stream
  Stream<Prod> get prodData {
    return productCollection.document(pid).snapshots()
        .map(_prodDataFromSnapshot);
  }

  Future getProductsList() async {
    List itemsList = [];

    try {
      await productCollection.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((snapshot) {
          itemsList.add(Prod(
              pid : snapshot.documentID,
              category: snapshot.data['category'],
              subcategory: snapshot.data['subcategory'],
              brand: snapshot.data['brand'],
              name: snapshot.data['name'],
              actualPrice: snapshot.data['actualPrice'],
              discountPrice: snapshot.data['discountPrice'],
              rating: snapshot.data['rating'],
              quantity: snapshot.data['quantity'],
              description: snapshot.data['description'],
              productPic: snapshot.data['productPic']
          ));
        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsCategoryList(String category) async {
    List itemsList = [];

    try {
      await productCollection.where('category', isEqualTo: category).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((snapshot) {
          itemsList.add(Prod(
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
          ));
        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Prod> getProductList(String id) async {
    DocumentSnapshot snapshot = await productCollection.document(id).get();
    Prod result = Prod(
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
    return result;
  }

}
