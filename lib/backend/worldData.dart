import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldData {

 Future getData() async {
    http.Response data =
        await http.get("https://corona.lmao.ninja/v2/all");
    if (data.statusCode == 200) {
      return jsonDecode(data.body);
    } else {
      return AlertDialog(
        title: Text("Data Not Available"),
      );
    }
  }
}
