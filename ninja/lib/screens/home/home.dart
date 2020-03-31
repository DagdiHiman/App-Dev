//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ninja/models/brew.dart';
import 'package:ninja/screens/home/settings_form.dart';
import 'package:ninja/services/auth.dart';
import 'package:ninja/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

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
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
          ),
          elevation: 5.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person_pin, color: Colors.brown[700],size: 25.0,),
                label: Text("Logout", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: Colors.brown[800]),),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.brown[700],size: 25.0,),
              label: Text('Settings', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: Colors.brown[800]),),
              onPressed: () => _showSettingsPanel(),
            )

          ],
          backgroundColor: Colors.lightBlueAccent[700],
        ),
        backgroundColor: Colors.blue[50],
          body: BrewList(),
      ),
    );
  }
}
