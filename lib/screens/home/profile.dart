import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:GreenKey/models/user.dart';
import 'package:GreenKey/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreenKey/services/database.dart';
import 'package:GreenKey/screens/home/profileform.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PickedFile _imageFile;
  File newimg;
  PickedFile tempimg;
  dynamic x;
  bool upload =false;
  Future getImage(x) async {
    tempimg = await ImagePicker().getImage(source: x);
    setState((){
      newimg = File(tempimg.path);
      upload = tempimg==null ? false : true;
    });
  }
  String _currentName;
  String _currentPhonenumber;
  String _currentAddress;
  String _currentEmail;
  String _currentProfilepic;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    Future uploadPic(BuildContext context) async{
      var randomno = Random(50);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('Profile Pics/$_currentEmail.jpg');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(newimg);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      String downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      _currentProfilepic = downloadUrl;
      upload = false;
      await DatabaseService(uid: user.uid).updateUserData(
        _currentName,
        _currentPhonenumber,
        _currentEmail,
        _currentAddress,
        _currentProfilepic,
      );
      setState(() {
        newimg = null;
        tempimg = null;
        print(downloadUrl);
      });
    }

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
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
            _currentProfilepic = userData.profile_pic;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(icon: Icon(Icons.arrow_back,size: 30,color: Colors.grey[700],),
                  highlightColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },),
                backgroundColor: Colors.lightGreenAccent.shade400,
              ),
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Center(
                        child: Stack(
                            children:<Widget>[ Center(
                              child: newimg == null ?
                              CircleAvatar(
                                radius:66,
                                backgroundColor: Colors.lightGreenAccent.shade200,
                                backgroundImage: NetworkImage('$_currentProfilepic'),

                              )
                                  :
                              CircleAvatar(
                                radius: 66,
                                backgroundColor: Colors.lightGreenAccent.shade200,
                                backgroundImage: AssetImage('$newimg'),

                              ),
                            ),

                              Positioned(
                                top: 90.0,
                                right: 150.0,
                                child: upload==false ? InkWell(
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
                                ) : FlatButton(
                                    onPressed: () {
                                      uploadPic(context);
                                    },
                                    visualDensity: VisualDensity.compact,
                                    splashColor: Colors.blueGrey,

                                    child: Icon(Icons.file_upload,size: 50,color: Colors.grey[900],)/*Text(
                                  'upload',
                                  style: TextStyle(color: Colors.grey[800], fontSize: 18.0,fontWeight: FontWeight.bold),
                                ),*/
                                ),
                              ),
                            ]
                        ),

                      ),

                      SizedBox(height: 20.0),
                      Text(
                        'My Account',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 50.0),

                      Card(
                        color: Colors.lightGreenAccent.shade100,
                        margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.grey[800],
                          ),
                          title: Text(
                            userData.name,
                            style: TextStyle(fontSize: 18.0, fontFamily: 'Neucha'),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.grey[800],
                          ),
                          title: Text(
                            userData.email,
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.lightGreenAccent.shade100,
                        margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.grey[800],
                          ),
                          title: Text(
                            userData.phoneNumber,
                            style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.grey[800],
                          ),
                          title: userData.address == null ? Text('Not Entered', style: TextStyle(color: Colors.grey, fontFamily: 'BalooBhai', fontSize: 18.0),) :
                          Text(userData.address, style: TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      FlatButton.icon(
                        icon: Icon(Icons.edit),
                        color: Colors.lightGreenAccent.shade400,
                        label: Text('Edit'),
                        onPressed: () => _showSettingsPanel(),
                      ),
                      SizedBox(
                        height: 0.0,
                        width: 210,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          } else {
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