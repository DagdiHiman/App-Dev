import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19 Tracker',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.white, fontSize: 26.0,
              ),
            ),
        ),
      ),
    );
  }
}
