import 'package:flutter/material.dart';
import 'package:green_key/shared/loading.dart';
import 'package:green_key/services/database.dart';
import 'package:green_key/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  //form values
  String _currentName;
  String _currentPhonenumber;
  String _currentAddress;
  String _currentEmail;
  String _currentProfilePic;
  List cart;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    

    return StreamBuilder<Info>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData){

            Info userData = snapshot.data;
            _currentProfilePic = userData.profilePic;
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              reverse: true,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                  SizedBox(height: 20.0),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _currentProfilePic == null ? AssetImage('assets/account.png') : NetworkImage('$_currentProfilePic')
                  ),
                  SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        fillColor: Colors.white54,
                        filled: true,
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      validator: (val) => val.isEmpty ? 'Please enter a name' : null ,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        fillColor: Colors.white54,
                        filled: true,
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      validator: (val) => val.isEmpty ? 'Please enter an valid email' : null ,
                      onChanged: (val) => setState(() => _currentEmail = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.phoneNumber,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        fillColor: Colors.white54,
                        filled: true,
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      validator: (val) => val.length == 10 ? null : 'Enter a valid Phone number' ,
                      onChanged: (val) => setState(() => _currentPhonenumber = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        fillColor: Colors.white54,
                        filled: true,
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),

                      ),
                      onChanged: (val) => setState(() => _currentAddress = val),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        textColor: Colors.green[50],
                        color: Colors.green[800],
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentPhonenumber ?? userData.phoneNumber,
                              _currentEmail ?? userData.email,
                              _currentAddress ?? userData.address,
                              _currentProfilePic ?? userData.profilePic,
                                userData.cart
                            );
                            Navigator.pop(context);
                          }
                        }
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

