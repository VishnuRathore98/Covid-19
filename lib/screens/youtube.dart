import 'news.dart';
import 'dart:async';
import 'dart:convert';
import 'about_app.dart';
import 'map_screen.dart';
import 'noInternet.dart';
import '../app_icon.dart';
import 'world_screen.dart';
import '../flutter_app_icons.dart';
import 'package:shimmer/shimmer.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:corona_app/backend/fetching.dart';
import 'package:corona_app/widgets/my_header_world.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class PlaylistShow extends StatefulWidget {
  @override
  _PlaylistShowState createState() => _PlaylistShowState();
}

class _PlaylistShowState extends State<PlaylistShow> {
  String url = Fetching().getYoutubeData();
  
  Future getData() async {
    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future worldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future aboutapp(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AboutApp()));
  }

  Future india(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }

  Future nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NoInternet()));
  }

  @override
  Widget build(BuildContext context) {
    int _currentindex = 3;
    GlobalKey _bottomNavigationKey = GlobalKey();
    return MaterialApp(
      title: 'NCov-19',
      home: SafeArea(
        child: Scaffold(
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
                    case 4:
                      {
                        aboutapp(context);
                        _currentindex = index;
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
                    MyHeaderW(
                      image: "images/mobile1.png",
                      textTop: "Videos related to ",
                      textBottom: "Coronavirus",
                    ),
                    FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) new ShimmerList();
                          return snapshot.hasData
                              ? new ListVideo(snapshot.data)
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: new ShimmerList()),
                                );
                        }),
                  ]),
            )),
      ),
    );
  }
}

class ListVideo extends StatelessWidget {
  final list;
  ListVideo(this.list);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: <Widget>[
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list == null ? 0 : list['pageInfo']['totalResults'],
              itemBuilder: (context, i) {
                return new GestureDetector(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new PlaylistShowVideo(
                          "https://youtube.com/embed/${list['items'][i]['contentDetails']['videoId']}"))),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(8)),
                      ListTile(
                          leading: Image.network(list['items'][i]['snippet']
                              ['thumbnails']['high']['url']),
                          title: Text(list['items'][i]['snippet']['title'])),
                      Divider(thickness: 2, color: Colors.black26),
                      // Padding(padding: EdgeInsets.all(8))
                    ],
                  )),
                );
              }),
        ]));
  }
}

class PlaylistShowVideo extends StatelessWidget {
  final String link;
  PlaylistShowVideo(this.link);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: WebviewScaffold(url: link)));
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 900;

    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 900 + offset;
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 200;
    double containerHeight = 15;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 80,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 1),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
