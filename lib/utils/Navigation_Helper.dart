import 'package:attendance_app/UI/login_page.dart';
import 'package:attendance_app/UI/qrcode.dart';
import 'package:attendance_app/UI/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static void goToRegistrationPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement<void, void>(context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const Register(),
      ),
    );
  }
  static void goToScanQRPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement<void, void>(context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ScanQR(),
      ),
    );
  }

  static void goToLoginPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement<void, void>(context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Login(),
      ),
    );
  }



}