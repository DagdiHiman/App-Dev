import 'package:flutter/material.dart';
import 'package:ninja/services/auth.dart';
import 'package:ninja/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //AuthService class instance (auth.dart)
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text state
  String email = "";
  String pswd = "";
  String error ="";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Coffee Crew",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 27.0, fontWeight: FontWeight.w700, color: Colors.blueAccent),
          ),
        ),
        elevation: 2.0,
        backgroundColor: Colors.blue[50],
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
            label: Text("SignIn",
              style: GoogleFonts.ubuntuCondensed(
                textStyle: TextStyle(fontSize:17.0, fontWeight: FontWeight.w400),
              ),
            ),
            icon: Icon(Icons.person, color: Colors.red, size: 28.0,),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: _regBody(),
    );
  }

  //body
  Widget _regBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 310.0,
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    gradient: LinearGradient(
                      colors: [
//                  Colors.redAccent,
//                  Colors.lightBlueAccent,
                        Color(0xFF42A5F5),
                        Color(0xFF36d1dc),
                        Color(0xFF42A5F5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 15),
                        spreadRadius: 5,
                        color: Colors.grey,
                        blurRadius: 20,
                      ),
                    ]),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "EMAIL",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue,width: 2.0,)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 2.0,)
                            )
                        ),
                        validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "PASSWORD",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue,width: 2.0,)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 2.0,)
                            )
                        ),
                        obscureText: true,
                        validator: (val) => val.length<6 ? 'Min. Password Length > 6' : null,
                        onChanged: (val) {
                          setState(() {
                            pswd = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)),
                          child: Text(
                            "REGISTER",
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmailAndPassword(email, pswd);
                              if (result == null) {
                                setState(() => error = 'Please supply a valid email !');
                                loading = false;
                              }
                            }
                          }
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 19.0),
            ),
          ],
        ),
      ),
    );
  }

}
