import 'package:flutter/material.dart';
import 'package:GreenKey/services/auth.dart';
import 'package:GreenKey/shared/loading.dart';

class LoginPage extends StatefulWidget {

  final Function toggleView;
  LoginPage({ this.toggleView });

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          centerTitle: true,
          title: Text('GreenKey',textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.lightGreen),),
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          fillColor: Colors.lightGreen[200],
                          filled: true,
                          labelText: 'User Name/ Email',
                          labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                        ),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val){
                          setState(() => email = val);
                        }
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        fillColor: Colors.lightGreen[200],
                        filled: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.length <6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
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
                        textColor: Colors.lightGreen,
                        color: Colors.white,
                        child: Text('Login',style: TextStyle(fontSize: 24),),
                        onPressed: () async {
                            if (_formKey.currentState.validate()){
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error =
                                  'Could Not SignIn With Those credentials';
                                  loading = false;
                                });
                              }
                            }
                        },
                      ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
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
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                ],
            )
          )
        )
    );
  }
}