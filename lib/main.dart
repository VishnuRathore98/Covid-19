// import 'package:corona_app/screens/world_screen.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() async {
  // http.Response data = await http.get("https://corona.lmao.ninja/v2/all");
  // var covidData = [
  //   jsonDecode(data.body)['cases'],
  //   jsonDecode(data.body)['deaths'],
  //   jsonDecode(data.body)['recovered'],
  //   jsonDecode(data.body)['todayCases'],
  //   jsonDecode(data.body)['active'],
  // ];
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final covidData;
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      initialRoute: 'wel',
      routes: {
        'wel': (context) => WorldScreen()
        // _MyAppState(covidData),
//        'no': (context) =>  HomePage(),
      },
    );
  }
}

class _MyAppState extends StatelessWidget {
  final covidData;
  _MyAppState(this.covidData);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new WorldScreen(),
        image: new Image.asset(
          "gif/covid.gif",
        ),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 230.0,
        loaderColor: Colors.black38,
        loadingText: Text(
          "GO Corona",
          style: TextStyle(
              letterSpacing: 8,
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}