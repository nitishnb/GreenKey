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
        address: snapshot.data['address'],
        profile_pic: snapshot.data['profile_pic']
    );
  }


  // get user doc stream
  Stream<Info> get userData {
    return accountCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}
