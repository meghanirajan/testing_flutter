import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_example/Model/Login_response_request.dart';
import 'package:login_example/Util/common_widget.dart';
import 'package:login_example/Util/shar_pref.dart';
import 'package:login_example/sign_in_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _switchValue=false;
  Login_response_request _login_response_request;
  String firstname="";
  String lastname="";
  void afterBuildFunction(BuildContext context) {
    _login_response_request=new Login_response_request(context);
    _login_response_request.LoginRequestData().then((value) {
      if(value.data!=null) {
        setState(() {
          firstname=value.data.firstName;
          lastname=value.data.lastName;
        });
      }
      else{
        commonMessage(context, "Data not Found");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Shared_Preferences.prefGetBool("FaceLockEnable", false)
        .then((value) {
          if(value) {
            setState(() {
              _switchValue = true;
            });
          }
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterBuildFunction(context));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,

                child: Text(
                  "Home Page",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(


                child: Text(
                  "First Name : $firstname",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(


                child: Text(
                  "Last Name : $lastname",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: Text("Enable Face/Touch Lock")),
                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        if(value) {
                          print("true");
                          Shared_Preferences.prefSetBool(
                              "FaceLockEnable", true);
                        }
                        else{
                          print("false");
                          Shared_Preferences.prefSetBool(
                              "FaceLockEnable", false);
                        }
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue[300],
                splashColor: Colors.blue[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Log Out",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
