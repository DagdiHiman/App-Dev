import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {

  final String title;
  final bool subtitle;

  const TitleText({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return subtitle ?
    Row(
      children: <Widget>[
        Expanded(child: Divider(color: Colors.red,)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
            style: GoogleFonts.getFont('Josefin Slab',
                textStyle: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800
                ),
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.red,)),
      ],
    )
        : Text(title,
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
