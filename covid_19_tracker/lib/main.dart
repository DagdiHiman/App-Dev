import 'package:covid_19_tracker/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'datasource.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme : GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: primaryBlack,
      ),
      home: HomePage(),
    );
  }
}

