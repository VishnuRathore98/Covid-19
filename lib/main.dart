import 'package:flutter/services.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


void main() async {runApp(MyApp());}

class MyApp extends StatelessWidget {

  MyApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      title: 'App Name',
      initialRoute: 'wel',
      routes: {
        'wel': (context) => _MyAppState()

      },
    );
  }
}

class _MyAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
          child: Center(
            child: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new WorldScreen(),
        image: new Image.asset(
            "gif/covid.gif"
        ),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 230.0,
        loaderColor: Colors.black38,
        loadingText: Text(
            "Covid-19",
            style: TextStyle(
                letterSpacing: 8,
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold),
        ),
      ),
          ),
    );
  }
}