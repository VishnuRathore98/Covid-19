
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:corona_app/screens/location_screen.dart';
import 'package:corona_app/screens/youtube.dart';
import 'package:corona_app/widgets/my_header_world.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'dart:async';
import 'package:flutter/material.dart';

import '../app_icon.dart';
import '../flutter_app_icons.dart';
import 'bot._screen.dart';
import 'noInternet.dart';
import 'about_app.dart';
import 'news.dart';
import 'package:corona_app/app_icon.dart';

class WorldLoad extends StatefulWidget {
  @override
  _WorldLoadState createState() => _WorldLoadState();
}

class _WorldLoadState extends State<WorldLoad> {

  Future LocationScreen1(context) async {

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  Future about_app1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => about_app()));
  }

  Future youtube(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlaylistShow()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  Future Nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
  }

  StreamSubscription connectivitySubscription;
  bool dialogshown = false;

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
    super.initState();
    checknet();
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  Widget build(BuildContext context) {
    GlobalKey _bottomNavigationKey = GlobalKey();
    int _currentindex = 0;
    return MaterialApp(
      title: 'Covid-19',
      home: SafeArea(
        child: Scaffold(
          floatingActionButton: Container(
              height: 80,
              width: 65,
              child: FloatingActionButton(
                elevation: 10,
                tooltip:"Chat Bot",
                backgroundColor: Colors.white,
                child: Icon(MyFlutterApp.chat,size: 47,color: Colors.black,),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Bot()));
                },
              )),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _currentindex,
            height: 70.0,
            items: <Widget>[
              Icon(Icons.public, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.library_books, size: 30),
              Icon(Icons.ondemand_video, size: 30),
              Icon(FlutterApp.virus,size: 35),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.black12,
            animationCurve: Curves.linearToEaseOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 1:
                    {
                      LocationScreen1(context);
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
                      about_app1(context);
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
     body: SingleChildScrollView(
       child: Container(
         child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               MyHeaderW(
                 image: "images/world.png",
                 textTop: "Covid-19 Spread",
                 textBottom: "Across World",

               ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Container(
                       child: Image.asset('gif/world.gif'),
                       height: 192.0,

                 ),
                    ),
                  ),


             ]
         ),

       ),
     ),
        ),
    ),





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

