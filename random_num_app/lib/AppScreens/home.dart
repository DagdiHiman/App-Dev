import 'dart:math';

import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightGreen,
      child: Center(
        child: Text(
          generateLuckyNum(),
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }

  String generateLuckyNum() {
    var random = Random();
    int num = random.nextInt(10);
    return "Hello Himan ! Ur lucky number is $num";
  }
}
