import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:green_key/screens/authenticate/signIn.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/shared/loading.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String message = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text(
          "GreenKey",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 32,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 40.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 15.0,),
                  Text(
                    "RESET PASSWORD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.green[400],
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //fillColor: Colors.lightGreen[200],

                      filled: true,
                      focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusColor: Colors.green[400],
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                    ),
                    validator: (val) => val.isEmpty ? "Please provide an Email" : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Please provide a proper Email ID",
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    textColor: Colors.green[50],
                    color: Colors.green[800],
                    child: Text(
                      "RESET YOUR PASSWORD",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        try {
                          await _auth.sendPasswordResetEmail(email);
                          setState(() {
                            message =
                            "An email to change your password is sent successfully";
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                        }
                        catch (e) {
                          setState(() {
                            error = "Unknown User!";
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 14.0
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
