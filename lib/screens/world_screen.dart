// import 'package:corona_app/backend/worldData.dart';
import 'package:corona_app/screens/location_screen.dart';
import 'package:corona_app/screens/wolrd_load.dart';
import 'package:corona_app/screens/youtube.dart';
import 'package:corona_app/widgets/my_header_world.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../app_icon.dart';
import '../flutter_app_icons.dart';
import 'bot._screen.dart';
import 'noInternet.dart';
import 'about_app.dart';
import 'news.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:corona_app/app_icon.dart';

class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {

  Future getData() async {
    final response = await http.get("https://corona.lmao.ninja/v2/all");
    return jsonDecode(response.body);
  }

  StreamSubscription connectivitySubscription;
  bool dialogshown = false;

  Future<bool> checkinternet() async {
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return (snapshot.hasData)?
              new WorldScreen1(snapshot.data):
              WorldLoad();


            }));
  }

  void checknet() {
    ConnectivityResult _previousResult;

    bool dialogshown = false;
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        dialogshown = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => noInternet()));
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

class WorldScreen1 extends StatefulWidget {
  var covidData;
  WorldScreen1(this.covidData);
  @override
  _WorldScreen1State createState() => _WorldScreen1State(covidData);
}

class _WorldScreen1State extends State<WorldScreen1> {
  final covidData;
  _WorldScreen1State(this.covidData);
  var totalCases, totalDeaths, recovered, todayCases, activeCases, critical;

  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

  Material myTextItems(String title, String subtitle,Color color) {
//    Color rang, var icon
    return Material(
      color: Colors.white,
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: Color(0x802196F3),
        child: Center(
          child: Padding(

            padding: EdgeInsets.all(8.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[

                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 25.0,
//                            fontWeight: FontWeight.bold,
                            fontFamily: 'Iceland'
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),

                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: color,
                            fontFamily: 'Iceland'
                        ),
                      ),
                    ]
                    ),
                )

              ],
            ),
          ),

    ));
  }

  Material mychart1Items(String title, var priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 5.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            image: DecorationImage(
                image: AssetImage('images/spread.gif'), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.indigo[700],
                          fontFamily: 'Iceland',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        priceVal,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Iceland',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Iceland',
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: new Sparkline(
                        data: data,
                        lineColor: Color(0xffff6101),
                        pointsMode: PointsMode.all,
                        pointSize: 8.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


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
    setState(() {

      totalCases = covidData['cases'];
      totalDeaths = covidData['deaths'];
      recovered = covidData['recovered'];
      todayCases = covidData['todayCases'];
      activeCases = covidData['active'];

    });
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
            physics: ScrollPhysics(),
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  MyHeaderW(
                    image: "images/world.png",
                    textTop: "Covid-19 Spread",
                    textBottom: "across World",
                  ),
                ])),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: mychart1Items(
                      "Total Cases", '$totalCases', "+ $todayCases today"),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: myCircularItems("Stats", "68.7M"),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: myTextItems(
                      "Total Deaths", '$totalDeaths',Color(0xFFb71c1c)),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: myTextItems(
                      "Recovered", '$recovered',Color(0xFF00C853)),
                ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: myTextItems(
                          "TodayCases", "+"+'$todayCases',Color(0xFFe57373)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: myTextItems(
                          "ActiveCases", '$activeCases',Color(0xFF607D8B)),
                    ),
                Padding(
                  padding: const EdgeInsets.all(8),

                ),

               

              ],
              staggeredTiles: [
                StaggeredTile.extent(4, 250.0),
                StaggeredTile.extent(4, 250.0),
                StaggeredTile.extent(2, 130.0),
                StaggeredTile.extent(2, 130.0),
                StaggeredTile.extent(2, 130.0),
                StaggeredTile.extent(2, 130.0),
                StaggeredTile.extent(2, 40.0)

                // StaggeredTile.extent(4, 250.0),
              ],
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
