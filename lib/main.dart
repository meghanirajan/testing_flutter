import 'package:flutter/material.dart';
import 'package:login_example/service/service_locator.dart';
import 'package:login_example/sign_in_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Example',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: SignInPage(),
    );
  }
}
/*

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}
*/
