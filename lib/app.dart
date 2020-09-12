import 'dart:convert';
import 'dart:ui' as bd;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:yeah_nah/api.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      title: "Yep/Nope",
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Image.asset("assets/10.gif",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitHeight),
          FutureBuilder<Api>(
            future: getApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: "assets/10.gif",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fitHeight,
                      image: snapshot.data.image,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.177,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: bd.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                            child: Center(
                              child: Text(
                                snapshot.data.answer.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 80,
                                    fontFamily: "fonta",
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 7.5,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              RaisedButton(
                                elevation: 5,
                                color: Colors.red,
                                child: Text(
                                  "Yep/Nope",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "fonta",
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                onPressed: () {
                                  setState(() {
                                    getApi();
                                  });
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.15,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/10.gif",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fitHeight,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
