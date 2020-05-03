import 'package:corona_app/screens/world_screen.dart';
import 'package:connectivity/connectivity.dart';
import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import 'package:corona_app/screens/location_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import 'dart:async';
import 'noInternet.dart';
import 'about_app.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Future WorldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future aboutapp(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => about_app()));
  }

  Future locationscreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  Future Nonet(context) async {
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
    int _currentindex = 0;
    return SafeArea(
          child: MaterialApp(
          title: 'App Name',
          home: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              index: _currentindex,
              height: 70.0,
              items: <Widget>[
                Icon(Icons.public, size: 30),
                Icon(Icons.search, size: 30),
                Icon(Icons.library_books, size: 30),
                Icon(Icons.ondemand_video, size: 30),
                Icon(
                  Icons.bug_report,
                  size: 30,
                ),
              ],
              color: Colors.white70,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.black38,
              animationCurve: Curves.linearToEaseOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      {
                        WorldScreen1(context);
                        _currentindex = index;
                      }
                      break;
                    case 1:
                      {
                        locationscreen1(context);
                        _currentindex = index;
                      }
                      break;
                    case 3:
                      {
                        aboutapp(context);
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
                  initialUrl: "https://maps.mapmyindia.com/corona?state",
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
        Nonet(context);
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
