import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat Box Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double _fontSize = 20;
  final double _baseFontSize = 20;
  double _fontScale = 1;
  double _baseFontScale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Box'),
      ),
      body: GestureDetector(

        onScaleStart: (ScaleStartDetails scaleStartDetails) {
          _baseFontScale = _fontScale;
        },

        onScaleUpdate: (ScaleUpdateDetails scaleUpdateDetails) {
          setState(() {
            _fontScale =
                (_baseFontScale * scaleUpdateDetails.scale).clamp(0.5, 5);

            _fontSize = _fontScale * _baseFontSize;
          });
        },

        child: Container(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(10,10),
                  color: Colors.grey,
                )
              ],
            color: Colors.lightGreenAccent,
          ),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(15),
          constraints: BoxConstraints(maxWidth: 330),
          child: Text.rich(buildTextSpan()),
        ),
      ),
    );
  }

  TextSpan buildTextSpan() {
    return TextSpan(
        style: TextStyle(
          fontSize: _fontSize,
        ),
        children: [
          TextSpan(text: 'Hello World , My name is Himan !!'),
          TextSpan(text: 'I am a flutter Dev :) !!'),
        ]
    );
  }
}