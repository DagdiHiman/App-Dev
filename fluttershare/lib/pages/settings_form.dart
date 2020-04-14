import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
       height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
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
              fontSize: 20.0, fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0,),
          Container(
            child: Row(
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
                Text(
                  '123',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.remove_red_eye,
                  color: Colors.deepPurple,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text(
                  'Total post views :',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  '123',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  color: Colors.deepPurple,
                  size: 30.0,
                ),
                SizedBox(width: 10.0,),
                Text(
                  'Distinct post views :',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  '123',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.0,),
          Icon(
            Icons.graphic_eq,
            color: Colors.blue[900],
            size: 80.0,
          ),

        ],
      ),
    );
  }
}
