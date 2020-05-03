import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PlaylistShow extends StatefulWidget {
  @override
  _PlaylistShowState createState() => _PlaylistShowState();
}

class _PlaylistShowState extends State<PlaylistShow> {
  Future getData() async {
    final response = await http.get("https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&maxResults=25&playlistId=PLq3AjOpSL6-1WmuNfVX199z6GsRJhU3J0&key=AIzaSyCTIJWdE_JIEesHHJYy5lGvflUdf-3lEIs");
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
      appBar: new AppBar(title: Text("Playlist")),
      body:
         FutureBuilder(
                      future: getData(),
                      builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                      ? new ListVideo(snapshot.data)
                      : Center(child: new CircularProgressIndicator());
                      })
            ),
    );
  }
}

class ListVideo extends StatelessWidget {
  var list;
  ListVideo(this.list);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list['pageInfo']['totalResults'],
        itemBuilder: (context, i) {
          // print(list);
          // return new Text(list['items'][i]['snippet']['title']);
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
                        ['thumbnails']['maxres']['url']),
                    title: Text(list['items'][i]['snippet']['title'])),
                Divider(thickness: 2, color: Colors.black26),
                // Padding(padding: EdgeInsets.all(8))
              ],
            )),
          );
        });
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






// class youtube extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("What is Covid-19 ?"),
//           backgroundColor:Color(0xFFd50000),
//         ),


//         body: Container(
//           child: WebView(
//             initialUrl: "https://www.trackcorona.live/informed",
//             javascriptMode:  JavascriptMode.unrestricted,
//           ),
//         )
//     );

//   }
// }