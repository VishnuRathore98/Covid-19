import 'dart:io';
import 'news.dart';
import 'dart:async';
import 'youtube.dart';
import 'noInternet.dart';
import 'map_screen.dart';
import '../app_icon.dart';
import '../flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:corona_app/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:corona_app/widgets/my_header.dart';
import 'package:corona_app/screens/world_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  Future worldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  TextEditingController insertedValue = TextEditingController();

  Future india(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
  }

  Future nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoInternet()));
  }

  Future youtube(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlaylistShow()));
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

  @override
  Widget build(BuildContext context) {
    int _currentindex = 4;
    GlobalKey _bottomNavigationKey = GlobalKey();
    return MaterialApp(
      title: 'About Covid-19',
      home: MaterialApp(
        title: 'Covid-19',
        home: SafeArea(
          child: Scaffold(
            floatingActionButton: Container(
                height: 100,
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Credits()));
                    },
                    child: Icon(
                      Icons.info,
                      size: 65,
                    ))),
            bottomNavigationBar: CurvedNavigationBar(
              index: _currentindex,
              key: _bottomNavigationKey,
              height: 70.0,
              items: <Widget>[
                Icon(Icons.public, size: 30),
                Icon(MyFlutterApp.nation, size: 30),
                Icon(Icons.library_books, size: 30),
                Icon(Icons.ondemand_video, size: 30),
                Icon(FlutterApp.virus, size: 35),
              ],
              color: Colors.white70,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.black12,
              animationCurve: Curves.linearToEaseOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) async {
                setState(() {
                  switch (index) {
                    case 0:
                      {
                        worldScreen1(context);
                        _currentindex = index;
                      }
                      break;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyHeader(
                    image: "icons/coronadr.svg",
                    textTop: "Get to know",
                    textBottom: "About Covid-19.",
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Symptoms",
                          style: kTitleTextstyle,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SymptomCard(
                              image: "images/headache.jpg",
                              title: "Headache",
                            ),
                            SymptomCard(
                              image: "images/cough.jpg",
                              title: "Caugh",
                            ),
                            SymptomCard(
                              image: "images/fever.jpg",
                              title: "Fever",
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SymptomCard(
                              image: "images/flu.jpg",
                              title: "Flu",
                            ),
                            SymptomCard(
                              image: "images/breath.jpg",
                              title: "Out of Breath",
                            ),
                            SymptomCard(
                              image: "images/throat.jpg",
                              title: "Sore Throat",
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Prevention",
                          style: kTitleTextstyle,
                        ),
                        SizedBox(height: 20),
                        PreventCard(
                          text:
                              "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                          image: "images/wear_mask.jpg",
                          title: "Wear face mask",
                        ),
                        PreventCard(
                          text:
                              "Hand-washing with soap and water is a far more powerful weapon against germs than many of us realize.",
                          image: "images/wash_hands.jpg",
                          title: "Wash your hands",
                        ),
                        PreventCard(
                          text:
                              "Keeping space between yourself and other people outside of your home. Stay at least 6 feet from other people",
                          image: "images/distancing.jpg",
                          title: "Maintain Social Distancing",
                        ),
                        PreventCard(
                          text:
                              "Don’t be a super-spreader. Stay home. Stay alive. #stayhome #staysafe",
                          image: "images/stayhome.jpg",
                          title: "Stay Home",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checknet() {
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

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 110,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 120,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                height: 130,
                width: MediaQuery.of(context).size.width - 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                          fontSize: 20, fontFamily: 'Iceland'),
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 16, fontFamily: 'Iceland'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 6,
              color: kShadowColor,
            ),
          ],
        ),
        child: Wrap(
          children: <Widget>[
            Image.asset(image, height: 90),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Iceland'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/cover_page.png"),
                    fit: BoxFit.contain),
              ),
            ),
             Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/1.png"),
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/2.png"),
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/3.png"),
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/credits.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
