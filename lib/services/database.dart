import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference greenCollection = Firestore.instance.collection('green');
  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await greenCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

}