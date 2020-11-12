import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:login_example/home_page.dart';

class LocalAuthenticationService {
  final _auth = LocalAuthentication();

  bool isAuthenticated = false;

  Future<void> authenticate(BuildContext context) async {
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: 'authenticate to access',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      print("$isAuthenticated===================succes===============");
    } on PlatformException catch (e) {
      print(e);
    }
    if(isAuthenticated) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomePage()));
      print("===================succes===============");
    }
  }
}