import 'package:GreenKey/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreenKey/models/user.dart';
import 'package:GreenKey/services/database.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentPhonenumber;
  String _currentAddress;
  String _currentEmail;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<Info>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData){

            Info userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Profile',
                    style: TextStyle(fontSize: 18.0),
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
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentPhonenumber ?? userData.phoneNumber,
                              _currentEmail ?? userData.email,
                              _currentAddress ?? userData.address,
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}