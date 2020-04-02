//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ninja/models/brew.dart';
import 'package:ninja/screens/home/settings_form.dart';
import 'package:ninja/services/auth.dart';
import 'package:ninja/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {

  //instance of AuthService (auth.dart)
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(

          title: Text(
            "Coffee Crew",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
            ),
          ),
          elevation: 5.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person_pin, color: Colors.lightGreenAccent,size: 25.0,),
              label: Text("Logout",
                style: GoogleFonts.workSans(textStyle:TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.lightGreenAccent),
                ),),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.lightGreenAccent,size: 25.0,),
              label: Text("Settings",
                style: GoogleFonts.workSans(textStyle:TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.lightGreenAccent),
                ),),
              onPressed: () => _showSettingsPanel(),
            )

          ],
          backgroundColor: Colors.lightBlueAccent[700],
        ),
        backgroundColor: Colors.blue[50],
          body: Container(
              child: BrewList(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/cb.png'),
                  fit: BoxFit.cover,
                ),
              ),
          ),
      ),
    );
  }
}
