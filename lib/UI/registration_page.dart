import 'package:attendance_app/utils/Navigation_Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:ui';

void main() => runApp(Register());

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double height, width;
  String name, email, mobile_no, password, confirm_password;
  TextEditingController _nameTextFieldController = TextEditingController();
  TextEditingController _emailTextFieldController = TextEditingController();
  TextEditingController _mobilenoTextFieldController = TextEditingController();
  TextEditingController _passwordTextFieldController = TextEditingController();
  TextEditingController _confirmpasswordTextFieldController =
      TextEditingController();

  void submitUserFormData() async {
    if (_nameTextFieldController.text.trim().isEmpty) {
      _nameTextFieldController.text = "";
      Fluttertoast.showToast(
          msg: " Enter Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
      return;
    }
    if (_emailTextFieldController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: " Enter Mail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
      return;
    }
    if (_emailTextFieldController.text.trim().isNotEmpty) {
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
    if (_mobilenoTextFieldController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: " Enter Mobile Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
      return;
    } else {
      RegExp regExp = new RegExp(r'(^[6-9][0-9]{9}$)');
      if (!regExp.hasMatch(_mobilenoTextFieldController.text.trim()) ||
          _mobilenoTextFieldController.text.length != 10) {
        Fluttertoast.showToast(
            msg: " Enter Valid Number",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.black);
        return;
      }
    }
    if (_passwordTextFieldController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: " Enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
      return;
    }
    if (_passwordTextFieldController.text !=
        _confirmpasswordTextFieldController.text) {
      Fluttertoast.showToast(
          msg: "Password Doesn't match !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.black);
      return;
    } else {
      RegExp validationRegex = RegExp(r'^.*(?=.{6,})(?=.*[@#$%^&+=*-.]).*$');
      if (!validationRegex.hasMatch(_passwordTextFieldController.text.trim())) {
        Fluttertoast.showToast(
            msg:
                "Password Must contain at least 6 characters and one special symbol!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.black);
        return;
      }
    }
    createUsers();
  }

  Future<void> createUsers() async {
    {
      try {
        final User user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _emailTextFieldController.text,
                    password: _passwordTextFieldController.text))
            .user;
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": _nameTextFieldController.text,
          "mobile_number": _mobilenoTextFieldController.text,
          "password": _passwordTextFieldController.text,
          "email": _emailTextFieldController.text,
        }).then(
          (value) {
            NavigationHelper.goToLoginPage(context);
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Registration'),
            ),
            body: Padding(
                padding: EdgeInsets.only(top: 100, left: 50, right: 50),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: _nameTextFieldController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                    ),
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
                        controller: _mobilenoTextFieldController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile No',
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: _passwordTextFieldController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: _confirmpasswordTextFieldController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 40,
                        padding:
                            EdgeInsets.only(left: 100, top: 10, right: 100),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Register'),
                          onPressed: () {
                            submitUserFormData();
                          },
                        )),
                    Container(
                        height: 60,
                        child: Row(
                          children: <Widget>[
                            Text('Already have  an account?'),
                            FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                ' Login.!',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                NavigationHelper.goToLoginPage(context);
                                //signup screen
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                  ],
                ))));
  }
}
