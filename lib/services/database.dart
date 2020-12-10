import 'package:GreenKey/models/account.dart';
import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference accountCollection = Firestore.instance.collection('account');

  Future<void> updateUserData(String name, String phoneNumber, String email, String address, String profile_pic) async {
    return await accountCollection.document(uid).setData({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address == '' ? null : address,
      'profile_pic': profile_pic,
    });
  }

  // userData from snapshot
  Info _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Info(
        uid: uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        phoneNumber: snapshot.data['phoneNumber'],
        address: snapshot.data['address']
    );
  }


  // get user doc stream
  Stream<Info> get userData {
    return accountCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}

class ProdDatabase{
  final String pid;

  ProdDatabase({ this.pid });

  // collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');



  Prod _prodDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data['name']);
    return Prod(
        pid: pid,
        name: snapshot.data['name'],
        mrp: snapshot.data['mrp'],
        price: snapshot.data['price'],
        stars: snapshot.data['stars'],
        company: snapshot.data['company'],
        category: snapshot.data['category'],
        description: snapshot.data['description'],
    );
  }


  // get user doc stream
  Stream<Prod> get prodData {
    return productCollection.document(pid).snapshots()
        .map(_prodDataFromSnapshot);
  }

}