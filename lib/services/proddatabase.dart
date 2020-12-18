import 'package:GreenKey/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProdDatabase{
  final String pid;

  ProdDatabase({ this.pid });

  // collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');


  Future updateProductData(String pid, String category, String subcategory, String brand, String name, num discountPrice, num quantity, String description, num rating, num actualPrice, String productPic) async {
      return await productCollection.document(pid).setData({
        "category" : category,
        "subcategory" : subcategory,
        "brand" : brand,
        "name" : name,
        "mrp": actualPrice,
        "quantity" : quantity,
        "description" : description,
        "stars" : rating,
        "price" : discountPrice,
        "image_url" : productPic
      });
  }

  Prod _prodDataFromSnapshot(DocumentSnapshot snapshot) {
    return Prod(
      name: snapshot.data['name'],
      mrp: snapshot.data['mrp'],
      price: snapshot.data['price'],
      stars: snapshot.data['stars'],
      brand: snapshot.data['brand'],
      category: snapshot.data['category'],
      subcategory: snapshot.data['subcategory'],
      quantity: snapshot.data['quantity'],
      description: snapshot.data['description'],
      image_url: snapshot.data['image_url'],
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
            pid: snapshot.documentID,
            name: snapshot.data['name'],
            mrp: snapshot.data['mrp'],
            price: snapshot.data['price'],
            stars: snapshot.data['stars'],
            brand: snapshot.data['brand'],
            category: snapshot.data['category'],
            subcategory: snapshot.data['subcategory'],
            quantity: snapshot.data['quantity'],
            description: snapshot.data['description'],
            image_url: snapshot.data['image_url'],
          ));
        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getProductsCategoryList(String subcategory) async {
    List itemsList = [];

    try {
      await productCollection.where('subcategory', isEqualTo: subcategory).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((snapshot) {
          itemsList.add(Prod(
            pid: snapshot.documentID,
            name: snapshot.data['name'],
            mrp: snapshot.data['mrp'],
            price: snapshot.data['price'],
            stars: snapshot.data['stars'],
            brand: snapshot.data['brand'],
            category: snapshot.data['category'],
            subcategory: snapshot.data['subcategory'],
            quantity: snapshot.data['quantity'],
            description: snapshot.data['description'],
            image_url: snapshot.data['image_url'],
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
      mrp: snapshot.data['mrp'],
      price: snapshot.data['price'],
      stars: snapshot.data['stars'],
      brand: snapshot.data['brand'],
      category: snapshot.data['category'],
      subcategory: snapshot.data['subcategory'],
      quantity: snapshot.data['quantity'],
      description: snapshot.data['description'],
      image_url: snapshot.data['image_url'],
    );
    return result;
  }
}