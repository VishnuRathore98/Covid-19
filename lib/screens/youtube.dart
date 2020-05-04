import 'package:corona_app/widgets/my_header_world.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shimmer/shimmer.dart';
import '../flutter_app_icons.dart';
import 'about_app.dart';
import 'location_screen.dart';
import 'news.dart';
import 'noInternet.dart';
import 'world_screen.dart';

class PlaylistShow extends StatefulWidget {
  @override
  _PlaylistShowState createState() => _PlaylistShowState();
}

class _PlaylistShowState extends State<PlaylistShow> {
  Future getData() async {
    final response = await http.get("https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&maxResults=25&playlistId=PLq3AjOpSL6-1WmuNfVX199z6GsRJhU3J0&key=AIzaSyCTIJWdE_JIEesHHJYy5lGvflUdf-3lEIs");
    return jsonDecode(response.body);
  }
  Future WorldScreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldScreen()));
  }

  Future aboutapp(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => about_app()));
  }

  Future locationscreen1(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  Future news1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => news()));
  }
  Future Nonet(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => noInternet()));
  }
  @override
  Widget build(BuildContext context) {
    int _currentindex = 3;
    GlobalKey _bottomNavigationKey = GlobalKey();
    return MaterialApp(
      title: 'App Name',
          home: SafeArea(
            child: Scaffold(
                bottomNavigationBar: CurvedNavigationBar(
                  index: _currentindex,
                  key: _bottomNavigationKey,

                  height: 70.0,
                  items: <Widget>[
                    Icon(Icons.public, size: 30),
                    Icon(Icons.search, size: 30),
                    Icon(Icons.library_books, size: 30),
                    Icon(Icons.ondemand_video, size: 30),
                    Icon(
                        FlutterApp.virus,size: 35
                    ),
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
                            WorldScreen1(context);
                            _currentindex = index;
                          }
                          break;
                        case 1:
                          {
                            locationscreen1(context);
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
         MyHeaderW(
         image: "images/mobile1.png",
             textTop: "Videos related to ",
             textBottom: "Coronavirus",
         ),
              FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                            ? new ListVideo(snapshot.data)
                            :Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: new ShimmerList()),
                            );
                            }),
      ]
         ),
       )
              ),
          ),
        );
  }
}

class ListVideo extends StatelessWidget {
  var list;
  ListVideo(this.list);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
          children: <Widget>[
      ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list == null ? 0 : list['pageInfo']['totalResults'],
          itemBuilder: (context, i) {
            int j = (list['pageInfo']['totalResults']-1)-i;

            return new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new PlaylistShowVideo(
                      "https://youtube.com/embed/${list['items'][j]['contentDetails']['videoId']}"))),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8)),
                  ListTile(
                      leading: Image.network(list['items'][j]['snippet']
                          ['thumbnails']['high']['url']),
                      title: Text(list['items'][j]['snippet']['title'])),
                  Divider(thickness: 2, color: Colors.black26),
                  // Padding(padding: EdgeInsets.all(8))
                ],
              )),
            );
          }),
  ]
      )
    );
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
    print(containerWidth);
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