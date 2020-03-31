import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninja/services/auth.dart';
import 'package:ninja/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //AuthService class instance (auth.dart)
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text state
  String email = "";
  String pswd = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Coffee Crew",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700, color: Colors.blueAccent),
        ),
        elevation: 2.0,
        backgroundColor: Colors.blue[50],
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              label: Text("SignUp", style: TextStyle(fontSize:17.0, fontWeight: FontWeight.w400 ),),
              icon: Icon(Icons.person, color: Colors.red, size: 28.0,),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: _signInBody(),
    );
  }

  //body
  Widget _signInBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 310.0,
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF42A5F5),
                      Color(0xFF36d1dc),
                      Color(0xFF5b86e5),
//                  Colors.deepOrangeAccent[400],
//                  Colors.white70,
//                  Colors.lightGreenAccent[400],
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
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      decoration: InputDecoration(
                          labelText: "EMAIL",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,width: 2.0,)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2.0,)
                          )
                      ),
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
                      validator: (val) => val.length<6 ? 'Min. Password Length > 6' : null,
                      decoration: InputDecoration(labelText: "PASSWORD",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue,width: 2.0,)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 2.0,)
                          )
                      ),
                      obscureText: true,
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
                          "SIGN IN",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.signInWithEmailAndPassword(email, pswd);
                            if (result == null) {
                              setState(() {
                              error = 'Could not sign in with those credentials';
                              loading = false;
                              });
                            }
                          }
                        }
                        ),
                  ],
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
