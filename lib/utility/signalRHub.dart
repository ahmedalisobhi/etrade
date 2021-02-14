import 'package:signalr_flutter/signalr_flutter.dart';
import 'package:ultimate_demo/utility/constants.dart';
import 'package:ultimate_demo/utility/streams/orders_stream.dart';
import 'package:ultimate_demo/utility/streams/signout_stream.dart';

class SignalRHub {
  static SignalR signalR;

  static Future<void> startConnection() async {
    //print('start connection process');
    signalR = SignalR('http://192.168.69.37/messagingservice', "EtradeHub",
        queryString:
            'AccessToken=${StaticVariables.accessToken != null ? StaticVariables.accessToken.accessToken : ""}',
        hubMethods: ["SignOutUser", "GetPendingOrders"],
        statusChangeCallback: (status) => print('hub state $status'),
        hubCallback: _onReceiveNotification);
    await signalR.connect();
  }

  static _onReceiveNotification(methodName, message) {
    if (methodName == 'SignOutUser') {
      //logout
      if (message != '') {
        //showErrorMessage('receive ' + message);
        SignoutStream.addToStream(message);
        signalR.stop();
      }
    } else if (methodName == 'GetPendingOrders') {
      //
      //print(message);
      OrdersStream.addToStream(message);
    }
  }

  static subscripeToHub(String pageName, dynamic data) {
    signalR.invokeMethod<dynamic>("Subscripe",
        arguments: [pageName, data]).catchError((error) {
      print(error.toString());
    });
  }

  static stopConnection() {
    signalR.stop();
  }
}
