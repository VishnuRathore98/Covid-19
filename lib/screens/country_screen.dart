import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'map_screen.dart';
import 'noInternet.dart';

class CountryScreen extends StatefulWidget {
  final covidData;
  CountryScreen(this.covidData);
  @override
  _CountryScreenState createState() => _CountryScreenState(covidData);
}

class _CountryScreenState extends State<CountryScreen> {
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

  final covidData;
  _CountryScreenState(this.covidData);
  @override
  Widget build(BuildContext context) {

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
        appBar: AppBar(
          title: Text(countryName + " Covid-19"),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Image.network(url))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: StaggeredGridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 15.0,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              children: <Widget>[
                tile("Total Cases", totalCases, Colors.pink),
                tile("Recovered", recovered, Color(0xFF00C853)),
                tile("Total Deaths", totalDeaths, Colors.redAccent),
                tile("Today Cases", todayCases, Color(0xFFe57373)),
                tile("Today Deaths", todayDeaths, Color(0xFFb71c1c)),

                tile("Active Cases", active, Colors.blueGrey),
                tile("Critical", critical, Color(0xFFFFEA00)),
              ],
              staggeredTiles: [
                StaggeredTile.extent(2, 100),
                StaggeredTile.count(1, 1),
                StaggeredTile.extent(1, 155),
                StaggeredTile.extent(1, 155),
                StaggeredTile.extent(1, 155),
                StaggeredTile.count(1, 1),
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
    color: Colors.white,
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
                              color: textColor,
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
