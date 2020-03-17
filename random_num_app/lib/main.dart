import "package:flutter/material.dart";
import 'AppScreens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "First Flutter App !",
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "My First App",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            backgroundColor: Colors.lightGreen[700],
          ),
          body: FirstScreen(),
        ));
  }
}
