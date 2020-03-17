import 'package:flutter/material.dart';
import 'package:fourth_app/SIForm.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.greenAccent,
      brightness: Brightness.dark,
    ),
  ));
}