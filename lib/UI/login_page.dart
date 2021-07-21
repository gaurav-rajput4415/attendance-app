import 'package:attendance_app/utils/Navigation_Helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailTextFieldController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void submitUserFormData() async {
    if (_emailTextFieldController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: " Enter Mail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
      return;
    }
    if (_passwordController.text
        .trim()
        .isNotEmpty) {
      RegExp emailValid = new RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailValid.hasMatch(_emailTextFieldController.text.trim())) {
        Fluttertoast.showToast(
            msg: " Enter Valid Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.black);
        return;
      }
    }
    loginUser();
  }

  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailTextFieldController.text,
          password: _passwordController.text)
          .then((FirebaseUser) {
        NavigationHelper.goToScanQRPage(context);
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
    }
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Login'),
            ),
            body: Padding(
                padding: EdgeInsets.only(top: 200, left: 50, right: 50),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: _emailTextFieldController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Id',
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding:
                            EdgeInsets.only(left: 100, top: 10, right: 100),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () {
                            submitUserFormData();
                          },
                        )),
                    Container(
                        height: 60,
                        child: Row(
                          children: <Widget>[
                            Text('Does not have account?'),
                            FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                ' Register..!',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                NavigationHelper.goToRegistrationPage(context);
                                //signup screen
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))
                  ],
                ))));
  }
}
