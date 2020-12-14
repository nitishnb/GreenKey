import 'package:GreenKey/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdDatabase{
  final String pid;

  ProdDatabase({ this.pid });

  // collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');

  List<Prod> _prodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Prod(
          pid: doc.documentID,
          name: doc.data['name'] ?? "",
          mrp: doc.data['mrp'] ?? 0.0,
          price: doc.data['price'] ?? 0.0,
          stars: doc.data['stars'] ?? 0.0,
          brand: doc.data['brand'] ?? "",
          category: doc.data['category'] ?? "",
          description: doc.data['description'] ?? "",
          image_url: doc.data['image_url'] ?? "",
      );
    }).toList();
  }

  // get brews stream
  Stream<List<Prod>> get products {
    return productCollection.snapshots()
        .map(_prodListFromSnapshot);
  }

  Prod _prodDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data);
    return Prod(
      name: snapshot.data['name'],
      mrp: snapshot.data['mrp'],
      price: snapshot.data['price'],
      stars: snapshot.data['stars'],
      brand: snapshot.data['brand'],
      category: snapshot.data['category'],
      description: snapshot.data['description'],
      image_url: snapshot.data['image_url'],
    );
  }


  // get user doc stream
  Stream<Prod> get prodData {
    return productCollection.document(pid).snapshots()
        .map(_prodDataFromSnapshot);
  }

}