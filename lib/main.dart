import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yeah_nah/api.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "YeNah",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = "https://yesno.wtf/api/";

  @override
  void initState() {
    super.initState();
    getApi();
  }

  Future<Api> getApi() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return Api.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent,));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder<Api>(
        future: getApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Image.network(
                  snapshot.data.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    snapshot.data.answer,
                    style: TextStyle(fontSize: 80, color: Colors.white),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
