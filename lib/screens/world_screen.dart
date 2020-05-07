import 'dart:io';
import 'news.dart';
import 'dart:async';
import 'dart:convert';
import 'about_app.dart';
import 'map_screen.dart';
import 'noInternet.dart';
import '../app_icon.dart';
import 'bot._screen.dart';
import '../flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:corona_app/app_icon.dart';
import 'package:connectivity/connectivity.dart';
import 'package:corona_app/screens/youtube.dart';
import 'package:corona_app/backend/fetching.dart';
import 'package:corona_app/screens/world_load.dart';
import 'package:corona_app/screens/country_screen.dart';
import 'package:corona_app/widgets/my_header_world.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


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

  // Future

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return (snapshot.hasData)
                ? new WorldScreen1(snapshot.data)
                : WorldLoad();
          }),
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NoInternet()));
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
  final covidData;
  WorldScreen1(this.covidData);
  @override
  _WorldScreen1State createState() => _WorldScreen1State(covidData);
}

class _WorldScreen1State extends State<WorldScreen1> {
  final covidData;
  _WorldScreen1State(this.covidData);
  var totalCases, totalDeaths, recovered, todayCases, activeCases, critical;
  TextEditingController insertedValue = TextEditingController();

  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  Material myTextItems(String title, String subtitle, Color color) {
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
                          style:
                              TextStyle(fontSize: 25.0, fontFamily: 'Iceland'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: 30.0,
                              color: color,
                              fontFamily: 'Iceland'),
                        ),
                      ]),
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
                image: AssetImage('gif/spread.gif'), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
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

  Future india(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
  }

  Future aboutapp1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AboutApp()));
  }

  Future youtube(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlaylistShow()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  Future nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoInternet()));
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

  Future _getData() async {
    final response = await http.get(Fetching().getWorldData());
    var covidData = jsonDecode(response.body);
    setState(() {
      totalCases = covidData['cases'];
      totalDeaths = covidData['deaths'];
      recovered = covidData['recovered'];
      todayCases = covidData['todayCases'];
      activeCases = covidData['active'];
    });
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

  // var message = true;
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
                tooltip: "Chat Bot",
                backgroundColor: Colors.white,
                child: Icon(
                  MyFlutterApp.chat,
                  size: 47,
                  color: Colors.black,
                ),
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
              Icon(MyFlutterApp.nation, size: 30),
              Icon(Icons.library_books, size: 30),
              Icon(Icons.ondemand_video, size: 30),
              Icon(FlutterApp.virus, size: 35),
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
                      india(context);
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
          body: RefreshIndicator(
            onRefresh: _getData,
            child: SingleChildScrollView(
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
                    child: new TextFormField(
                      controller: insertedValue,
                      decoration: new InputDecoration(
                        // errorText: message?'Enter country name':Null,
                        suffix: GestureDetector(
                            child: Icon(Icons.search),
                            onTap: () async {
                              if (insertedValue.text != '') {
                                var covidData = await Fetching()
                                    .getCovidData(insertedValue.text.toLowerCase());
                                if(covidData!=null)
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryScreen(
                                            covidData, insertedValue.text)));
                              }
                            }),
                        labelText: "Search Country",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(
                              style: BorderStyle.solid, width: 10),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "country name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: mychart1Items(
                        "Total Cases", '$totalCases', "+ $todayCases today"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: myTextItems(
                        "Total Deaths", '$totalDeaths', Color(0xFFb71c1c)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: myTextItems(
                        "Recovered", '$recovered', Color(0xFF00C853)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: myTextItems(
                        "TodayCases", "+" + '$todayCases', Color(0xFFe57373)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: myTextItems(
                        "ActiveCases", '$activeCases', Color(0xFF607D8B)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                  ),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(4, 250.0),
                  StaggeredTile.extent(4, 70.0),
                  StaggeredTile.extent(4, 250.0),
                  StaggeredTile.extent(2, 170.0),
                  StaggeredTile.extent(2, 170.0),
                  StaggeredTile.extent(2, 170.0),
                  StaggeredTile.extent(2, 170.0),
                  StaggeredTile.extent(2, 40.0)

                  // StaggeredTile.extent(4, 250.0),
                ],
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
