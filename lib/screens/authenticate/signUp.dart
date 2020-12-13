import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/shared/loading.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override

  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String phoneNumber = '';
  String name = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool loading = false;

  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
//      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200], Colors.brown[400]]
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 15.0,),
                    Icon(
                      Icons.person,
                      size: 100.0,
                      color: Colors.green[800],
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      "SIGNUP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.green[800],
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
                              color: Colors.green[800],
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusColor: Colors.green[800],
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? "Please provide a name" : RegExp(r"^[a-zA-Z]+").hasMatch(val) && val.length > 3? null : "Please provide a proper name",
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //fillColor: Colors.lightGreen[200],
                        filled: true,
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[800],
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? "Please provide a mobile number" : RegExp(r"^[0-9]+").hasMatch(val) && val.length == 10 ? null : "Please provide a proper mobile number",
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //fillColor: Colors.lightGreen[200],
                        filled: true,
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[800],
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
                              //borderSide: BorderSide(color: Colors.green[400])
                          ),
                          //fillColor: Colors.lightGreen[200],
                          filled: true,
                          focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green[800],
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          focusColor: Colors.green[400],
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        ),
                        validator: (val) => val.isEmpty ? "Please provide a password" : val.length > 5 ? null : "The password must be at least six characters",
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
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
                        filled: true,
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[800],
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? "Please provide a password" : val == password ? null : "The password and confirm password should be matched",
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          confirmPassword = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      textColor: Colors.green[50],
                      color: Colors.brown[800],
                      child: Text(
                        "SIGN UP",
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
                          dynamic result = await _auth.signUpWithEmailAndPassword(email, password, name, phoneNumber);
                          if (result == null)
                            setState(() {
                              error = "Oops, couldn't Sign up with these credentials!";
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
                          "Have an account already?",
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
                              "Sign in",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.brown[800],
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
      ),
    );
  }
}
