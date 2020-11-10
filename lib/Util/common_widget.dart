import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';



void commonMessage(BuildContext context, String message) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(
          "Message",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content:
            new Text(message, style: TextStyle(fontWeight: FontWeight.w500)),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "Ok",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Widget LoadingIcon(){
  return Center(
    child: Image.asset("assets/images/loading.gif"),
  );
}