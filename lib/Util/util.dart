import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_example/Util/common_widget.dart';

Connectivity connectivity = Connectivity();

Future<bool> isConnectNetworkWithMessage(BuildContext context) async {
  var connectivityResult = await connectivity.checkConnectivity();
  bool isConnect = getConnectionValue(connectivityResult);
  if (!isConnect) {
    commonMessage(
      context,
      "Network connection required to fetch data.",
    );
  }
  return isConnect;
}

Future<bool> isConnectNetwork(BuildContext context) async {
  var connectivityResult = await connectivity.checkConnectivity();
  bool isConnect = getConnectionValue(connectivityResult);
  return isConnect;
}

// Method to convert the connectivity to a string value
bool getConnectionValue(var connectivityResult) {
  bool status = false;
  switch (connectivityResult) {
    case ConnectivityResult.mobile:
      status = true;
      break;
    case ConnectivityResult.wifi:
      status = true;
      break;
    case ConnectivityResult.none:
      status = false;
      break;
    default:
      status = false;
      break;
  }
  return status;
}

void onLoading(BuildContext context, {String strMessage}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                height: 100,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
                margin: EdgeInsets.only(bottom: 20),
              ),
              (strMessage != null)
                  ? Flexible(
                      child: Text(
                        strMessage,
                        maxLines: 2,
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      flex: 1,
                    )
                  : Container(),
            ],
          ),
        ),
      );
    },
  );
}

const formatDate = 'dd/MM';

String getDateDifference(DateTime dateTime) {
  if (dateTime == null) return "";

  if (dateTime.day == DateTime.now().day &&
      dateTime.month == DateTime.now().month &&
      dateTime.year == DateTime.now().year) {
    return "Today";
  } else if (dateTime.day == DateTime.now().subtract(Duration(hours: 24)).day &&
      dateTime.month == DateTime.now().subtract(Duration(hours: 24)).month &&
      dateTime.year == DateTime.now().subtract(Duration(hours: 24)).year) {
    return "Yesterday";
  } else {
    return DateTime.now().difference(dateTime).inDays.toString() + "days ago";
  }
}

String getStatusName(String statusid) {
  switch (statusid) {
    case "0":
      {
        return "Draft";
      }
    case "1":
      {
        return "New Request";
      }
    case "2":
      {
        return "Insufficient Data";
      }
    case "4":
      {
        return "On Going";
      }
    case "5":
      {
        return "Hold";
      }
    case "6":
      {
        return "Closed";
      }
    case "7":
    default:
      {
        return "Completed";
      }
  }
}

void showDia(BuildContext context,String message){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView(
                      children: <Widget>[
                        Text(message.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancle",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: const Color(0xFF1BC0C5),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

