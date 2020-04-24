import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {

  final String title;

  const TitleText({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 28.0,
            letterSpacing: -0.8,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }
}
