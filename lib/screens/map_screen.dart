import 'package:corona_app/app_icon.dart';
import 'package:corona_app/backend/fetching.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:corona_app/screens/youtube.dart';
import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import 'dart:async';
import '../flutter_app_icons.dart';
import 'news.dart';
import 'noInternet.dart';
import 'about_app.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var url = Fetching().getMapData();
  Future locationScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future aboutapp1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => About_app()));
  }

  Future youtube(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlaylistShow()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  Future noNet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
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
    int _currentindex = 1;
    GlobalKey _bottomNavigationKey = GlobalKey();
    return SafeArea(
      child: MaterialApp(
          title: 'Covid-19',
          home: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              index: _currentindex,
              key: _bottomNavigationKey,
              height: 70.0,
              items: <Widget>[
                Icon(Icons.public, size: 30),
                Icon(MyFlutterApp.nation, size: 34),
                Icon(Icons.library_books, size: 30),
                Icon(Icons.ondemand_video, size: 30),
                Icon(FlutterApp.virus, size: 35),
              ],
              color: Colors.white70,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.black12,
              animationCurve: Curves.linearToEaseOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      {
                        locationScreen1(context);
                        _currentindex = index;
                      }
                      break;
                    case 2:
                      {
                        news1(context);
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
                        aboutapp1(context);
                        _currentindex = index;
                      }
                      break;
                  }
                });
              },
            ),
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
        noNet(context);
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
