import 'package:green_key/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/services/database.dart';

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
  String _currentProfilepic;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData){

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    ' Update your Account : ',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.uname,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null ,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.email,
                    validator: (val) => val.isEmpty ? 'Please enter an valid email' : null ,
                    onChanged: (val) => setState(() => _currentEmail = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.mobile,
                    validator: (val) => val.length == 10 ? null : 'Enter a valid Phone number' ,
                    onChanged: (val) => setState(() => _currentPhonenumber = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.address,
                    onChanged: (val) => setState(() => _currentAddress = val),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.grey[800],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.lightGreenAccent.shade400,fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.uname,
                            _currentPhonenumber ?? userData.mobile,
                            _currentEmail ?? userData.email,
                            _currentAddress ?? userData.address,
                            _currentProfilepic ?? userData.profile_pic,
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
