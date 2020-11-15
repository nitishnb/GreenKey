import 'package:GreenKey/models/user.dart';
import 'package:GreenKey/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreenKey/services/database.dart';
import 'package:GreenKey/screens/home/profileform.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

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
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40.0),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/account.png'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'My Account',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 25,
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Edit'),
                    onPressed: () => _showSettingsPanel(),
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
                    color: Colors.white,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.teal[900],
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
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.mail_sharp,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        userData.email,
                        style:
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.teal[900],
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
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        userData.address ?? 'Not Entered' ,
                        style:
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                      ),
                    ),
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
