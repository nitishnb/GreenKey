import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:green_key/screens/home/profileForm.dart';
import 'package:green_key/shared/loading.dart';
import 'package:green_key/services/database.dart';
import 'package:green_key/models/user.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  PickedFile _imageFile;
  File newimg;
  var tempimg;
  dynamic x;
  bool upload =false;
  Future getImage(x) async {
    tempimg = await ImagePicker.pickImage(source: x);
    setState((){
      newimg = tempimg;
      upload = tempimg ==null ? false : true;
    });
  }

  String _currentName;
  String _currentPhonenumber;
  String _currentAddress;
  String _currentEmail;
  String currentProfilepic;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    Future uploadPic(BuildContext context) async{
      var randomno = Random(50);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('Profile Pics/$_currentEmail.jpg');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(newimg);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      currentProfilepic = downloadUrl;
      //a = downloadUrl;
      upload = false;
      await DatabaseService(uid: user.uid).updateUserData(
        _currentName,
        _currentPhonenumber,
        _currentEmail,
        _currentAddress,
        currentProfilepic,
      );
      setState(() {
        newimg = null;
        tempimg = null;
        print(currentProfilepic);
      });
    }

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamBuilder<Info>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            Info userData = snapshot.data;
            _currentName = userData.name;
            _currentPhonenumber = userData.phoneNumber;
            _currentAddress = userData.address;
            _currentEmail = userData.email;
            currentProfilepic = userData.profilePic;
            print(currentProfilepic);
            return SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Center(
                        child: Stack(
                            children:<Widget>[ Center(
                              child: newimg == null ?
                              CircleAvatar(
                                radius:66,
                                backgroundColor: Colors.blue,
                                backgroundImage: NetworkImage('$currentProfilepic'),
                              )
                                  :
                              CircleAvatar(
                                radius: 66,
                                backgroundColor: Colors.lightGreenAccent.shade200,
                                backgroundImage:  FileImage(newimg),
                                //backgroundImage: AssetImage('$newimg'),
                              ),
                            ),
                              Positioned(
                                top: 105.0,
                                right: 110.0,
                                child: upload == false ?
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSheet()),
                                    );
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                    size: 28.0,
                                  ),
                                )
                                    :
                                FlatButton(
                                    onPressed: () {
                                      uploadPic(context);
                                    },
                                    visualDensity: VisualDensity.compact,
                                    splashColor: Colors.blueGrey,
                                    child: Icon(Icons.file_upload,size: 28,color: Colors.grey[900],)
                                ),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'My Account',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                        ),
                      ),
                      FlatButton.icon(
                          icon: Icon(Icons.edit),
                          label: Text('Edit'),
                          onPressed: () {
                            _showSettingsPanel();
                          }
                      ),
                      SizedBox(
                        height: 10.0,
                        width: 200,
                        child: Divider(
                          color: Colors.teal[100],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Card(
                        color: Colors.green[100],
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            userData.name,
                            style: TextStyle(fontSize: 13.0, fontFamily: 'Neucha'),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.green[100],
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            userData.email,
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 13.0),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.green[100],
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            userData.phoneNumber ?? "NO",
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 13.0),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.green[100],
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            userData.address ?? 'Not Entered' ,
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return Loading();
          }
        }
    );
  }
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: 280,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                getImage(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 100, 100);
  }
  bool shouldReclip(oldClipper) {
    return false;
  }
}