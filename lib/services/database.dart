import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/green.dart';
import 'package:green_key/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference greenCollection = Firestore.instance.collection('green');
  final CollectionReference allProducts = Firestore.instance.collection('products');
  Future<void> updateUserData(String uname, String mobile,String email,String address,String profile_pic) async {
    return await greenCollection.document(uid).setData({
      'uname': uname,
      'mobile': mobile,
      'email': email,
      'address': address,
      'profile_pic': profile_pic,
    });
  }


  // brew list from snapshot
  List<Green> _greenListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Green(
          uname: doc.data['uname'] ?? '',
          mobile: doc.data['mobile'] ?? 0,
          email: doc.data['email'] ?? '0'
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        uname: snapshot.data['uname'],
        mobile: snapshot.data['mobile'],
        email: snapshot.data['email'],
        address: snapshot.data['address'],
        profile_pic: snapshot.data['profile_pic'],
    );
  }

  // get green stream
  Stream<List<Green>> get green {
    return greenCollection.snapshots()
        .map(_greenListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return greenCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
  Future<void> createUserData(
      String name, int discount_price, int actual_price, String img_url) async {
    return await allProducts
        .document(uid)
        .setData({'name': name, 'discount_price': discount_price, 'actual_price': actual_price,'img_url':img_url});
  }


  Future getProductsList() async {
    List itemsList = [];

    try {
      await allProducts.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}

