import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  @override
  Widget build(BuildContext parentContext) {

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _formKey = GlobalKey<FormState>();
    String username;

    submit() {
      final form = _formKey.currentState;
      if(form.validate()) {
        form.save();
        SnackBar snackBar = SnackBar(
          content: Text('Hey, Welcome $username !'),);
        _scaffoldKey.currentState.showSnackBar(snackBar);
        Timer(Duration(seconds: 2),(){
          Navigator.pop(context, username);
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: header( titleText: 'Set up your Profile '),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "Create a Username :",
                      style: TextStyle( fontSize: 21.0, color: Colors.pink),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: TextFormField(
                        validator: (val){
                          if(val.trim().length < 3 || val.isEmpty){
                            return 'Username too Short !';
                          }
                          else if(val.trim().length > 12 ){
                            return 'Username too Long !';
                          }
                          else {
                            return null;
                          }
                        },
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle:  TextStyle(
                            color: Colors.pink,
                            fontSize: 18.0,
                          ),
                          hintText: 'Must be atleast 3 characters',
                        ),
                        autofocus: false,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.pinkAccent ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
