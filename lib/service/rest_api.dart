import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:login_example/Util/util.dart';
import 'package:login_example/local_data/app_state.dart';

AppState appState = AppState();

/*MultipartFile.fromString(
          'userimg', imagePath.readAsStringSync(),
          contentType: new MediaType('image', 'jpg'))*/

class RestApi {
  BuildContext _context;


  RestApi({context}) {
    _context = context;
  }

  Future<Response> getRequestLoginData() async {
    bool isConnect = await isConnectNetworkWithMessage(_context);
    if (!isConnect) return null;

    var _header = {"request_type": "api", "Accept": "application/json"};

    Response response = await get(appState.host + appState.urlGetRequestlogindata,
        headers: _header);

    showResponseData(response);

    return response;
  }

  void showResponseData(var responseBody) {
    {
      try {
        print("Response status: ${responseBody.statusCode}");
        print("Response body length: ${responseBody.contentLength}");
        print("Response headers: ${responseBody.headers}");
        print("Response request: ${responseBody.request}");
        print("Response body: ${responseBody.body}");
      } catch (e) {
        print(e);
      }
    }
  }

}
