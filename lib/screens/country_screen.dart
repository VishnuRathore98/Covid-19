import 'package:corona_app/backend/fetching.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:corona_app/screens/youtube.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import '../constant.dart';
import '../flutter_app_icons.dart';
import 'about_app.dart';
import 'location_screen.dart';
import 'news.dart';
import 'noInternet.dart';

class CountryScreen extends StatefulWidget {
  final covidData, cName;
  CountryScreen(this.covidData, this.cName);
  @override
  _CountryScreenState createState() => _CountryScreenState(covidData, cName);
}

class _CountryScreenState extends State<CountryScreen> {
  final covidData, cName;
  var countryName,
      totalCases,
      todayCases,
      totalDeaths,
      todayDeaths,
      recovered,
      active,
      critical,
      url;
  _CountryScreenState(this.covidData, this.cName);

  StreamSubscription connectivitySubscription;

  Future Nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
  }

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
    var f = Fetching();
    var covidData = await f.getData(cName);
    setState(() {
      countryName = covidData['country'];
      totalCases = covidData['cases'];
      todayCases = covidData['todayCases'];
      totalDeaths = covidData['deaths'];
      todayDeaths = covidData['todayDeaths'];
      recovered = covidData['recovered'];
      active = covidData['active'];
      critical = covidData['critical'];
      url = covidData['countryInfo']['flag'];
    });
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
    Future LocationScreen1(context) async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldScreen()));
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

    GlobalKey _bottomNavigationKey = GlobalKey();
    int _currentindex = 1;
    var countryName = covidData['country'],
        totalCases = covidData['cases'],
        todayCases = covidData['todayCases'],
        totalDeaths = covidData['deaths'],
        todayDeaths = covidData['todayDeaths'],
        recovered = covidData['recovered'],
        active = covidData['active'],
        critical = covidData['critical'],
        url = covidData['countryInfo']['flag'];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _currentindex,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.public, size: 30),
            Icon(Icons.search, size: 30),
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
                case 0:
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
              }
            });
          },
        ),
        appBar: AppBar(
          title: Text(" Cases in $countryName "),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Image.network(url))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _getData,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 15.0,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              children: <Widget>[
                tile("Total Cases", totalCases, Colors.blueGrey),
                tile("Recovered", recovered, Color(0xFF00C853)),
                tile("Total Deaths", totalDeaths, Color(0xFFb71c1c)),
                tile("Today Cases", todayCases, Colors.grey[600]),
                tile("Today Deaths", todayDeaths, Colors.grey[600]),
                tile("Active Cases", active, Colors.grey[600]),
                tile("Critical", critical, Colors.grey[600]),
              ],
              staggeredTiles: [
                // StaggeredTile.extent(1, 155),
                StaggeredTile.extent(2, 100),
                StaggeredTile.extent(1, 165),
                StaggeredTile.extent(1, 165),
                StaggeredTile.extent(1, 155),
                StaggeredTile.extent(1, 155),
                StaggeredTile.extent(1, 155),
                StaggeredTile.extent(1, 155),
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

Widget tile(String name, var variableName, var textColor) {
  return Material(
    color: textColor,
    elevation: 8.0,
//    shadowColor: Color(0xFF4B4B4B),
    borderRadius: BorderRadius.circular(40),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //numbers
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text('+' + '$variableName',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Iceland')),
                    )),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          '$name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              fontSize: 20.0,
                              fontFamily: 'Iceland'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}