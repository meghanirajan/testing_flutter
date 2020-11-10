import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }


  AppState._internal();

  String host = "https://api.mocki.io/v1/";
  String urlGetRequestlogindata = 'b4209c6d';
}
