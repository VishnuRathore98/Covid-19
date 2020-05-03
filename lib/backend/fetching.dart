import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fetching {

  Future getData(String insertedValue) async {
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
}
