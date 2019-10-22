import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: ErrorHome(),
      ),
    );
  }
}

class ErrorHome extends StatefulWidget {
  @override
  _ErrorHomeState createState() => _ErrorHomeState();
}

class _ErrorHomeState extends State<ErrorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityWidgetWrapper(
        child: AlertDialog(
          content: new Text("No Internet Connection"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Exit"),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ),
    );
  }
}
