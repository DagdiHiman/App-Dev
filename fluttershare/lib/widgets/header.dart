import 'package:flutter/material.dart';

//Shader Linear Gradient for Title Texts
final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.pinkAccent, Colors.purple[300]],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

AppBar header({bool isAppTitle=false, String titleText}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      isAppTitle ? "InstaFlutter" : titleText,
      style: TextStyle(
        letterSpacing: 2.0,
        fontSize: isAppTitle ? 55.0 : 25.0,
        fontFamily: isAppTitle ? 'Signatra' : '',
        foreground: Paint()..shader = linearGradient,
        //color: Colors.deepPurple,
      ),
    ),
    backgroundColor: Colors.black,
  );
}
