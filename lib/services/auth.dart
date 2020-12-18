import 'package:GreenKey/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:GreenKey/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword (String email, String password, String name, String phoneNumber) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData(name, phoneNumber, email, '', null, []);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // reset password
  Future sendPasswordResetEmail(String email) async {
    try{
      return _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;


    await DatabaseService(uid : user.uid).updateUserData(user.displayName, user.phoneNumber, user.email, user.phoneNumber, user.photoUrl, []);
    print('This is uid : ${user.uid}');

    return _userFromFirebaseUser(user);
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

}