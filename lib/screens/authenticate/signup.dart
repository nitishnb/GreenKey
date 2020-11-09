import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/shared/loding.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  final Function toggleView;
  SignupPage({ this.toggleView });

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignupPage> {
  final AuthService _auth = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  String uname = '';
  String email = '';
  String password = '';
  String mobile = '';
  String conpassword= '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('GreenKey',textAlign: TextAlign.center,style: TextStyle(fontSize: 32),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightGreenAccent.shade400,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Icon(
                    Icons.assignment_ind,
                    size: 140,
                    color: Colors.lightGreenAccent.shade400,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 0,bottom: 30),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.lightGreenAccent.shade400,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'fonts/IndieFlower-Regular.ttf',
                            fontSize: 50),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'User Name :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade400,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? 'User nam  is mandatory' : null,
                      onChanged: (val) {
                        setState(() => uname = val);},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'Email :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade400,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? 'Email is mandatory' : null,
                        onChanged: (val) {
                        setState(() => email = val);},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: TextFormField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'Mobile no :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade400,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? "Mobile number can't be empty" : null,
                        onChanged: (val) {
                        setState(() => mobile = val);},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'Password :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade400,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.length < 6 ? 'Password must include 6+ chars long' : null,
                        onChanged: (val) {
                        setState(() => password = val);},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: ' Conform Password :',
                        labelStyle: TextStyle(color: Colors.lightGreenAccent.shade400,fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val != password ? 'Confirm password should match with Password' : null,
                        onChanged: (val) {
                        setState(() => conpassword = val);},
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.lightGreenAccent.shade400,
                        child: Text('SignUP',style: TextStyle(fontSize: 24),),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmailAndPassword(uname,mobile,email, password);
                              if(result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Failed to Register!';
                                });
                              }
                            }
                          },
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

                          Text('Have an existing account?'),
                          FlatButton(
                            textColor: Colors.lightGreenAccent.shade400,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                ],
              ),
            )));
  }
}