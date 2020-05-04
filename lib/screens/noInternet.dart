import 'package:corona_app/widgets/header_nointernet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../flutter_app_icons.dart';

// ignore: camel_case_types
class noInternet extends StatefulWidget {
  @override
  _noInternetState createState() => _noInternetState();
}


// ignore: camel_case_types
class _noInternetState extends State<noInternet> {


  @override
  Widget build(BuildContext context) {
    int _currentindex = 0;

    return MaterialApp(
      title: 'App Name',
      home: Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          index: _currentindex,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.public, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.whatshot, size: 30),
            Icon(Icons.ondemand_video, size: 30),
            Icon(FlutterApp.virus,size: 35),
          ],
          color: Colors.white70,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.black12,
          animationCurve: Curves.linearToEaseOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              switch (index) {
                case 1:
                  {
                    _currentindex = index;
                  }
                  break;
                case 2:
                  {
                    _currentindex = index;
                  }
                  break;
                case 3:
                  {
                    _currentindex = index;
                  }
                  break;
                case 4:
                  {
                    _currentindex = index;
                  }
                  break;
                default :
                  {
                    print("defalut");
                  }
                  break;
              }
            });
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyHeaderno(
                      textTop: "",
                      textBottom: "",

                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        child: Image.asset('gif/Internet1.gif'),
                        height: 300.0,

                      ),
                    ),
                    Center(

                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text("No connection",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 23.0,

                              )
                          ),
                        )

                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 50),
                          child: Text("No internet connection found. check your internet connection or try again",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize:15.0,
                              )
                          ),
                        )

                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: RaisedButton(
                            onPressed: () {
                              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                            },
                            child: Text(
                                'TRY AGAIN',
                                style: TextStyle(fontSize: 20)
                            ),
                          )
                        )

                    ),
                  ]
              ),

            ),
          ),
        ),
      ),
    );
  }
//  checknet() {
//    ConnectivityResult _previousResult;
//
//    bool dialogshown = false;
//    var connectivitySubscription = Connectivity()
//        .onConnectivityChanged
//        .listen((ConnectivityResult connresult) {
//      if (connresult == ConnectivityResult.none) {
//        dialogshown = true;
//        showDialog(
//            barrierDismissible: false,
//            context: context,builder: (_) => AssetGiffyDialog(
//          image: Image.asset('gif/internet.gif'),
//          title: Text('NO Internet Connection Found',
//            textAlign: TextAlign.center,
//            style: TextStyle(
//                fontSize: 22.0, fontWeight: FontWeight.w600),
//          ),
//          description: Text('Check your Internet Connection and try again',
//            textAlign: TextAlign.center,
//            style: TextStyle(),
//          ),
//          entryAnimation:EntryAnimation.BOTTOM_RIGHT,
//          onlyOkButton: true,
//          onOkButtonPressed:() {
//            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//          },
//        ) );
//      } else if (_previousResult == ConnectivityResult.none) {
//        checkinternet().then((result) {
//          if (result == true) {
//            if (dialogshown == true) {
//              dialogshown = false;
//              Navigator.pop(context);
//            }
//          }
//        });
//      }
//
//      _previousResult = connresult;
//    });
//
//  }
}
