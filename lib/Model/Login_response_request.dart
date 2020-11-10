import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:login_example/Model/Login_Response_Data.dart';
import 'package:login_example/Util/util.dart';
import 'package:login_example/service/rest_api.dart';

class Login_response_request{
  RestApi restApi;
  BuildContext context;

  Login_response_request(BuildContext context){
    this.context=context;
    restApi = RestApi(context: context);
  }

  Future<Login_Response_Data> LoginRequestData() async {
    onLoading(context, strMessage: "Loading");
    print("Model Send Request");
    Response response = await restApi.getRequestLoginData();
    Navigator.of(context).pop();
    if (response != null && response.body != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          Login_Response_Data profileChangePwdModel =
          Login_Response_Data.fromJson(jsonDecode(response.body));
          return profileChangePwdModel;
        } catch (ex) {
          showDia(context, response.body.toString());
        }
      }
    }
    return null;
  }

}