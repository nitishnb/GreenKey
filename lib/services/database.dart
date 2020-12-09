import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/models/green.dart';
import 'package:green_key/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference greenCollection = Firestore.instance.collection('green');
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

}