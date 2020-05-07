import '../flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:corona_app/widgets/header_nointernet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NoInternet extends StatefulWidget {
@override
  _NoInternetState createState() => _NoInternetState();
}


class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    int _currentindex = 0;

    return MaterialApp(
      title: 'Covid-19',
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
}
