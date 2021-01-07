import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:green_key/services/auth.dart';
import 'signup.dart';
import 'package:green_key/shared/loading.dart';

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
        backgroundColor: Colors.lightGreenAccent.shade100,
        appBar: AppBar(
          centerTitle: true,
          title: Text('GreenKey',textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.lightGreenAccent.shade200),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
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
                    color: Colors.blueGrey,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 0,bottom: 30),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'fonts/IndieFlower-Regular.ttf',
                            fontSize: 40,
                        decoration: TextDecoration.underline),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'User Name/ Email :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade200,fontWeight: FontWeight.bold),
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
                        fillColor: Colors.blueGrey,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                        labelText: 'Password :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade200,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                    },

                    textColor: Colors.white,
                    child: Text('Forgot Password..?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blueGrey)),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.blue,
                        color: Colors.white70,
                        child: Text('Login',style: TextStyle(fontSize: 24),),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null) {
                                setState(() {
                                  loading = false;
                                });
                                showDialog(context: context,
                                    builder:(context){
                                      return new AlertDialog(
                                        title: Text("Failed !",style: TextStyle(fontWeight: FontWeight.bold),),
                                        content: Text("Could'nt sign in with the provided credentials!",style: TextStyle(color: Colors.red),),
                                        actions: <Widget>[
                                          new MaterialButton(onPressed: (){
                                            Navigator.pop(context);
                                          },
                                            child: Text("OK"),)
                                        ],
                                      );
                                    }
                                );
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
                          Text('Does not have account?',style: TextStyle(color: Colors.blueGrey,fontSize: 16),),
                          FlatButton(
                            textColor: Colors.white,

                            onPressed: () {
                              widget.toggleView();
                          },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blue),
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
