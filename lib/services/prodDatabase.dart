import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/products.dart';

class ProductDatabase {

  String pid;
  ProductDatabase({this.pid});

  final CollectionReference productCollection = Firestore.instance.collection('product');

  Future updateProductData(String category, String subcategory, String brand, String name, String discountPrice, String quantity, String description, String rating, String actualPrice, String productPic) async {
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
            pid: snapshot.documentID.toString(),
            name: snapshot.data['name'].toString(),
            actualPrice: snapshot.data['actualPrice'].toString(),
            rating: snapshot.data['rating'].toString(),
            discountPrice: snapshot.data['discountPrice'].toString(),
            productPic: snapshot.data['productPic'].toString(),
            category: snapshot.data['category'].toString(),
            subcategory: snapshot.data['subcategory'].toString(),
            quantity: snapshot.data['quantity'].toString(),
            description: snapshot.data['description'].toString(),
            brand: snapshot.data['brand'].toString(),
          ));
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      print("Hi");
      return null;
    }
  }

  Future<List> getProductsCategoryList(String subcategory) async {
    List itemsList = [];
    try {
      await productCollection.where('subcategory', isEqualTo: subcategory).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((snapshot) {
          itemsList.add(Prod(
            pid: snapshot.documentID.toString(),
            name: snapshot.data['name'].toString(),
            actualPrice: snapshot.data['actualPrice'].toString(),
            rating: snapshot.data['rating'].toString(),
            discountPrice: snapshot.data['discountPrice'].toString(),
            productPic: snapshot.data['productPic'].toString(),
            category: snapshot.data['category'].toString(),
            subcategory: snapshot.data['subcategory'].toString(),
            quantity: snapshot.data['quantity'].toString(),
            description: snapshot.data['description'].toString(),
          ));
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List> getProductsDetails(String subcategory, String name) async {
    List itemsList = [];
    try {
      await productCollection.where('subcategory', isEqualTo: subcategory).where('name', isEqualTo: name).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((snapshot) {
          itemsList.add(Prod(
            pid: snapshot.documentID.toString(),
            name: snapshot.data['name'].toString(),
            brand: snapshot.data['brand'].toString(),
            actualPrice: snapshot.data['actualPrice'].toString(),
            rating: snapshot.data['rating'].toString(),
            discountPrice: snapshot.data['discountPrice'].toString(),
            productPic: snapshot.data['productPic'].toString(),
            category: snapshot.data['category'].toString(),
            subcategory: snapshot.data['subcategory'].toString(),
            quantity: snapshot.data['quantity'].toString(),
            description: snapshot.data['description'].toString(),
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
      pid: snapshot.documentID,
      name: snapshot.data['name'],
      actualPrice: snapshot.data['actualPrice'],
      rating: snapshot.data['rating'],
      discountPrice: snapshot.data['discountPrice'],
      productPic: snapshot.data['productPic'],
      brand: snapshot.data['brand'],
      category: snapshot.data['category'],
      subcategory: snapshot.data['subcategory'],
      quantity: snapshot.data['quantity'],
      description: snapshot.data['description'],
    );
    return result;
  }

  Future<void> deleteProduct(String pid) async {
    return productCollection.document(pid).delete();
  }
}

