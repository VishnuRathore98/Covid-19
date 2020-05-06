import 'package:corona_app/backend/fetching.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:connectivity/connectivity.dart';
import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import 'dart:async';
import '../app_icon.dart';
import '../flutter_app_icons.dart';
import 'map_screen.dart';
import 'noInternet.dart';
import 'about_app.dart';
import 'youtube.dart';

// ignore: camel_case_types
class news extends StatefulWidget {
  @override
  _newsState createState() => _newsState();
}

// ignore: camel_case_types
class _newsState extends State<news> {
String url = Fetching().getNewsData();
  Future worldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future aboutapp(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => About_app()));
  }

  Future india(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Maps()));
  }

  Future nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
  }

  Future youtube(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlaylistShow()));
  }

  StreamSubscription connectivitySubscription;
  bool dialogshown = false;
  static var isLoading = true;
  Future checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();

    checknet();
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int _currentindex = 2;
    GlobalKey _bottomNavigationKey = GlobalKey();
    return SafeArea(
          child: MaterialApp(
          title:'Covid-19',
          home: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              index: _currentindex,
              key: _bottomNavigationKey,
              height: 70.0,
              items: <Widget>[
                Icon(Icons.public, size: 30),
                Icon(MyFlutterApp.nation, size: 30),
                Icon(Icons.library_books, size: 30),
                Icon(Icons.ondemand_video, size: 30),
                Icon(
                  FlutterApp.virus,size: 35,
                ),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.black12,
              animationCurve: Curves.linearToEaseOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      {
                        worldScreen1(context);
                        _currentindex = index;
                      }
                      break;
                    case 1:
                      {
                        india(context);
                        _currentindex = index;
                      }
                      break;
                    case 3:
                      {
                        youtube(context);
                        _currentindex = index;
                      }
                      break;
                    case 4:
                      {
                        aboutapp(context);
                        _currentindex = index;
                      }
                      break;
                    default:
                      {
                        print("defalut");
                      }
                      break;
                  }
                });
              },
            ),

//          appBar: AppBar(
//            title: Text('About Covid-19'),
//          ),
            body: Stack(
              children: <Widget>[
                new WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (_) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
              ],
            ),
          )),
    );
  }

  void checknet() {
    ConnectivityResult _previousResult;

    bool dialogshown = false;
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        dialogshown = true;
        nonet(context);
      } else if (_previousResult == ConnectivityResult.none) {
        checkinternet().then((result) {
          if (result == true) {
            if (dialogshown == true) {
              dialogshown = false;
              Navigator.pop(context);
            }
          }
        });
      }

      _previousResult = connresult;
    });
  }
}
