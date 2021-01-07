import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/shared/loading.dart';
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
  String address='';
  String profile_pic='';
  List cart=[];

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                    Icons.assignment_ind,
                    size: 140,
                    color: Colors.blueGrey,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 0,bottom: 30),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'fonts/IndieFlower-Regular.ttf',
                            fontSize: 40,
                        decoration: TextDecoration.underline),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.lightGreenAccent.shade200,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'User Name :',
                        labelStyle: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),
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
                        filled: true,
                        fillColor: Colors.lightGreenAccent.shade200,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'Email :',
                        labelStyle: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),
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
                        filled: true,
                        fillColor: Colors.lightGreenAccent.shade200,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'Mobile no :',
                        labelStyle: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),
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
                        filled: true,
                        fillColor: Colors.lightGreenAccent.shade200,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: 'Password :',
                        labelStyle: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),
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
                        filled: true,
                        fillColor: Colors.lightGreenAccent.shade200,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.lightGreenAccent.shade400)),
                        labelText: ' Conform Password :',
                        labelStyle: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),
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
                        textColor: Colors.lightGreenAccent.shade200,
                        color: Colors.blueGrey,
                        child: Text('Signup',style: TextStyle(fontSize: 24,),),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmailAndPassword(uname,mobile,email,password,address,profile_pic,cart);
                              if(result == null) {
                                setState(() {
                                  loading = false;

                                });
                                showDialog(context: context,
                                    builder:(context){
                                      return new AlertDialog(
                                        title: Text("Failed !",style: TextStyle(fontWeight: FontWeight.bold),),
                                        content: Text("Could'nt Register your account in greenkey!",style: TextStyle(color: Colors.red),),
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

                          Text('Have an existing account?',style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold),),
                          FlatButton(
                            textColor: Colors.blueGrey,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
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