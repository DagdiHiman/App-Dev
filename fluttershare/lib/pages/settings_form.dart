import 'package:flutter/material.dart';
import 'package:fluttershare/pages/profileVisits.dart';
import 'package:fluttershare/widgets/progress.dart';

import 'home.dart';


class SettingsForm extends StatefulWidget {

  final String userId;
  final String postId;

  SettingsForm({this.userId, this.postId});

  @override
  _SettingsFormState createState() => _SettingsFormState(
    postId: this.postId,
    userId: this.userId,
  );
}

class _SettingsFormState extends State<SettingsForm> {

  final String userId;
  final String postId;

  _SettingsFormState({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      //width: MediaQuery.of(context).size.width,
      //height: 300.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Colors.blue[200],
          boxShadow: [BoxShadow(
            color: Colors.grey,
            offset: Offset(7.0,7.0),
            blurRadius: 7.0,
          )]
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Text(
            'Post Insights',
            style: TextStyle(
              fontSize:50.0, fontFamily: 'Signatra', wordSpacing: 2.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.mouse,
                  color: Colors.deepPurple,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text(
                  'Profile Visits :',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                RaisedButton.icon(
                  color: Colors.pinkAccent[100],
                  splashColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  icon: Icon(Icons.remove_red_eye, color: Colors.black,size: 25.0,),
                  label: Text("Click Here",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.black),
                  ),
                  onPressed: () => _showSettingsPanel(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0,),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  color: Colors.deepPurple,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text(
                  'Post views :',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                RaisedButton.icon(
                  color: Colors.pinkAccent[100],
                  splashColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  icon: Icon(Icons.remove_red_eye, color: Colors.black,size: 25.0,),
                  label: Text("Click Here",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.black),
                  ),
                  onPressed: () => {},
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0,),

          Icon(
            Icons.graphic_eq,
            color: Colors.blue[900],
            size: 90.0,
          ),

        ],
      ),
    );

  }
  void _showSettingsPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: ProfileVisits(userId: userId, postId: postId,),
      );
    });
  }
}