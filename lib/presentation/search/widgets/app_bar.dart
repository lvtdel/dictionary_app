import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: Colors.blueAccent,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
  );
}
