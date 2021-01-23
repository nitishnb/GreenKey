import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/models/account.dart';
import 'package:green_key/screens/authenticate/signIn.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference accountCollection = Firestore.instance.collection('account');

  Future updateUserData(String name, String phoneNumber, String email, String address, String profilePic, List cart) async {
    return await accountCollection.document(uid).setData({
      "name" : name,
      "phoneNumber" : phoneNumber,
      "email" : email,
      "address" : address == '' ? null : address,
      "profilePic" : profilePic == '' ? null: profilePic,
      "cart" : cart
    });
  }

  Info _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Info(
        uid: uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        phoneNumber: snapshot.data['phoneNumber'],
        address: snapshot.data['address'],
        profilePic: snapshot.data['profilePic'],
        cart : snapshot.data['cart']
    );
  }


  // get user doc stream
  Stream<Info> get userData {
    return accountCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Future getAccountList(String id) async {
    DocumentSnapshot variable = await accountCollection.document(id).get();
    return variable.data['cart'];
  }

  Future<void> addtoCart(String id, List<dynamic> cart) async {
    return await accountCollection.document(id).updateData({'cart': cart});
  }

}
