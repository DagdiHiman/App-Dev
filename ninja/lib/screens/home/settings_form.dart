import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ninja/models/user.dart';
import 'package:ninja/services/database.dart';
import 'package:ninja/shared/constant.dart';
import 'package:ninja/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars', style: GoogleFonts.ubuntu(),),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val ),
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.brown[200],
                      child: Text(
                        'Update',
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600 )
                        ),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? snapshot.data.sugars,
                              _currentName ?? snapshot.data.name,
                              _currentStrength ?? snapshot.data.strength
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

/*
                  RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.brown[200],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                      onPressed: () async {
                        print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);
                      }),

 */
