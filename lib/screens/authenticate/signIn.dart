import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:green_key/screens/authenticate/resetPassword.dart';
import 'package:green_key/screens/home/home.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override

  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  Widget build(BuildContext context) {
    return loading ? Home() : Scaffold(
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
                  Icon(
                    Icons.account_circle,
                    size: 100.0,
                    color: Colors.green[400],
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    "LOGIN",
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
                  SizedBox(height: 15.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.green[400])
                      ),
                      //fillColor: Colors.lightGreen[200],
                      //filled: true,
                      focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusColor: Colors.green[400],
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                    ),
                    obscureText: true,
                    validator: (val) => val.isEmpty ? "Please provide a password" : val.length > 5 ? null : "The password must be at least six characters",
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                  ),
//                  SizedBox(height: 5.0,),
                  RaisedButton(
                    textColor: Colors.green[50],
                    color: Colors.green[800],
                    child: Text(
                      "SIGN IN",
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
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null)
                          setState(() {
                            error = "Oops, couldn't Sign in with these credentials!";
                            loading = false;
                          });
                      }
                    },
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 13.0
                        ),
                      ),
                      //SizedBox(width: 10.0,),
                      FlatButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
