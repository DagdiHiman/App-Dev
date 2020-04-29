
import 'package:flutter/material.dart';
import 'package:fluttershare/pages/home.dart';

void main() {
//  Firestore.instance.settings(timestampsInSnapshotsEnabled: true).then((_) {
//    print("Timestamps enabled in snapshots\n");
//  }, onError: (_) {
//    print("Error enabling timestamps in snapshots\n");
//  });
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        //primarySwatch: primaryBlack,
        accentColor: Colors.purple,
      ),
    );
  }

  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
}
