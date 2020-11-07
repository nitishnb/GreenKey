import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:green_key/services/auth.dart';
import 'signup.dart';
import 'package:green_key/shared/loding.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({ this.toggleView });

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.lightGreenAccent.shade400,
        appBar: AppBar(
          centerTitle: true,
          title: Text('GreenKey',textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.lightGreenAccent.shade400),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Icon(
                    Icons.account_box,
                    size: 140,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 0,bottom: 30),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'fonts/IndieFlower-Regular.ttf',
                            fontSize: 50),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'User Name/ Email',
                        labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                    },
                    textColor: Colors.white,
                    child: Text('Forgot Password..?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.lightGreenAccent.shade400,
                        color: Colors.white,
                        child: Text('Login',style: TextStyle(fontSize: 24),),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null) {
                                setState(() {
                                  loading = false;
                                  error = "Could'nt sign in with these credentials!";
                                });
                              }
                            }
                          }
                      )),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 20.0,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          FlatButton(
                            textColor: Colors.white,

                            onPressed: () {
                              widget.toggleView();
                          },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                ],
              ),
            )));
  }
}
