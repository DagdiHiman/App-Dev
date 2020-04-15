import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/progress.dart';

import 'home.dart';

class ProfileVisits extends StatefulWidget {
  @override
  _ProfileVisitsState createState() => _ProfileVisitsState();
}

class _ProfileVisitsState extends State<ProfileVisits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Latest Visits to your Profile', style:
        TextStyle(
            fontSize: 19.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
        ],
      ),
    );
  }
//  usersList() {
//    return StreamBuilder(
//        stream: postRef
//                  .
//        ,
//        // ignore: missing_return
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//              return circularProgress();
//          }
//          else{
//
//          }
//    }
//
}