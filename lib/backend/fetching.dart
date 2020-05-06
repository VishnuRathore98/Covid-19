import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fetching {
  Future getCovidData(String insertedValue) async {
    http.Response data =
        await http.get("https://corona.lmao.ninja/v2/countries/$insertedValue");
    if (data.statusCode == 200) {
      return jsonDecode(data.body);
    } else {
      AlertDialog(
        title: Text("No Data Found"),
      );
    }
  }

  String getYoutubeData() {
    String url =
        "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&maxResults=25&playlistId=PLq3AjOpSL6-1WmuNfVX199z6GsRJhU3J0&key=AIzaSyCTIJWdE_JIEesHHJYy5lGvflUdf-3lEIs";
    return url;
  }

  String getNewsData() {
    String url = "https://inshorts.com/en/read/national";
    return url;
  }

  String getMapData() {
    String url = "https://www.covid19india.org/";
    return url;
  }

  String getBotData(){
    String url = "https://covid.apollo247.com/?utm_source=twitter&utm_medium=organic&utm_campaign=bot_scanner";
    return url;
  }

  String getWorldData(){
    String url = "https://corona.lmao.ninja/v2/all";
    return url;
  }
}
