import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:login_example/Model/Login_response_request.dart';
import 'package:login_example/Util/common_widget.dart';
import 'package:login_example/home_page.dart';
import 'package:login_example/Util/shar_pref.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  Login_response_request _login_response_request;

  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  bool _obscurePassword = true;

  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;
  String authorized = "Not authorized";
  bool _isAuthenticating = false;

  GlobalKey<FormState> loginformKey=GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _login_response_request = Login_response_request(this.context);
    Shared_Preferences.prefGetBool("FaceLockEnable", false)
        .then((value) {
      if(value) {
        _checkBiometrics();
      }
    });
  }


  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    if(!canCheckBiometrics){
      commonMessage(context, "BioMetrics data not available");
    }
    else{
      _getAvailableBiometrics();
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    if(availableBiometrics.length>0){

    }
    else{
      commonMessage(context,"No Biometric Found. Please First Add Biometric.");
    }
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    if(authenticated){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => HomePage()));
    }
    else{
      commonMessage(context, "You are not authorized with biometric data. Please login with your username and password");
      _cancelAuthentication();
    }

    /*final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      authorized = message;
    });*/
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Form(
              key: loginformKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: usernamecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 30),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black54,
                              ),
                              hintText: "Email/Phone Number",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if(value.isEmpty){
                                return "Email/Phone is Empty";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: passwordcontroller,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 30),
                              prefixIcon: Icon(
                                Icons.lock_open,
                                color: Colors.black54,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if(value.isEmpty){
                                return "Password is Empty";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue[400],
                                // gradient: LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.topRight,
                                //   colors: [
                                //     Colors.purple,
                                //     Colors.purple[400],
                                //     Colors.purple[300],
                                //     Colors.red[300],
                                //   ],
                                // ),
                              ),
                              child: MaterialButton(
                                // padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                onPressed: () {
                                  if(loginformKey.currentState.validate()){
                                    loginformKey.currentState.save();
                                    _login_response_request=new Login_response_request(context);
                                    _login_response_request.LoginRequestData().then((value) {
                                      if(value.data!=null) {
                                        if(value.data.email==usernamecontroller.text&&value.data.password==passwordcontroller.text){
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) => HomePage()));
                                        }
                                        else{
                                          commonMessage(context, "Username and Password is not found");
                                        }
                                      }
                                      else{
                                        commonMessage(context, "Data not Found");
                                      }
                                    });
                                  }


                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Center(
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
