import 'package:corona_app/screens/world_screen.dart';
import 'package:corona_app/screens/youtube.dart';
import 'package:corona_app/widgets/my_header.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:corona_app/backend/fetching.dart';
import 'package:corona_app/screens/country_screen.dart';
import 'about_app.dart';
import 'map_screen.dart';
import 'news.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var countryName;

  Future WorldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  TextEditingController insertedValue = TextEditingController();

  Future about_app1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => about_app()));
  }


  Future test1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlaylistShow()));
  }

  @override
  Widget build(BuildContext context) {
    int _currentindex = 1;
    return MaterialApp(
      title: 'App Name',
      home: Scaffold(
        floatingActionButton: Container(
            height: 65,
            width: 65,
            child: FloatingActionButton(
              backgroundColor: Colors.teal,
              child: Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Maps()));
              },
            )),
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentindex,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.public, size: 30),
            Icon(Icons.search, size: 30, color: Color(0xFF11249F)),
            Icon(Icons.library_books, size: 30),
            Icon(Icons.ondemand_video, size: 30),
            Icon(Icons.bug_report, size: 30),
          ],
          color: Colors.white70,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.black38,
          animationCurve: Curves.linearToEaseOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  {
                    WorldScreen1(context);
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
                    about_app1(context);
                    _currentindex = index;
                  }
                  break;
                case 4:
                  {
                    about_app1(context);
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
//      backgroundColor: Color(0x272b36),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyHeader(
                image: "icons/Drcorona.svg",
                textTop: "Get Data of your",
                textBottom: "Country",
              ),
              Center(
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: insertedValue,
                    decoration: InputDecoration(
                      labelText: 'Type Country Name',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),

              Center(
                child: Container(
                  height: 50,
                  width: 220,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () async {
                      if (insertedValue.text != '') {
                        var f = Fetching();
                        var covidData = await f.getData(
                            insertedValue.text.toLowerCase());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CountryScreen(covidData)));
                      }
                      else if (insertedValue.text ==  '') {
                        alertData();
                      }
                      else{
                             LocationScreen();
                      }
                    },
                    child: Text('Search',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alertData() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text(
          "NO Data Found",
        ),
        content: Text(
          "Please Enter A Correct Country Name",
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () =>
            { Navigator.pop(context)},
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
