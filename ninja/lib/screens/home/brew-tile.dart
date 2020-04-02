import 'package:flutter/material.dart';
import 'package:ninja/models/brew.dart';
import 'package:google_fonts/google_fonts.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({ this.brew });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: Card(
            color: Colors.blue[200],
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue[800])),
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/ci.png'),
                backgroundColor: Colors.brown[brew.strength],
              ),
              title: Text(brew.name, style:
                TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
                ),
              subtitle: Text('Takes ${brew.sugars} sugar(s)',style:  GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 16.0,),
              ),),
            ),
          ),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 10),
                  spreadRadius: 0,
                  color: Colors.brown[200],
                  blurRadius: 14.0,
                ),]
          ),
        ),

    );
  }
}