import 'package:flutter/material.dart';
import 'package:ninja/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //AuthService class instance (auth.dart)
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks ToDo",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
        ),
        elevation: 5.0,
        backgroundColor: Colors.lightBlueAccent[700],
      ),
      backgroundColor: Colors.blue[50],
      body: _signInBody(),
    );
  }

  //body 
  Widget _signInBody() {
    return Padding(
      padding: const EdgeInsets.only(top:16.0, left:16.0),
      child: Center(
        child: Container(
          child: RaisedButton(
            child: Text("SIGN IN ANONYMOUSLY",
              style: TextStyle(fontSize: 17.0),
            ),
            onPressed: () async {
              dynamic res = await _auth.signInAnon();
              if(res == null){
                print("ERROR Signing in :( ");
              }
              else{
                print("SIGNED IN :)\n");
                print(res.uid);
              }
            }
          ),
        ),
      ),
    );
  }

}
