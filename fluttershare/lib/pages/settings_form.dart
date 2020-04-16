import 'package:flutter/material.dart';
import 'package:fluttershare/pages/profileVisits.dart';


class SettingsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



//class SettingsForm extends StatefulWidget {
//  @override
//  _SettingsFormState createState() => _SettingsFormState();
//}
//
//class _SettingsFormState extends State<SettingsForm> {
//  @override
//  
//}


/*

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
          SizedBox(height: 0.0,),
          Row(
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(Icons.remove_red_eye, color: Colors.black,size: 25.0,),
                label: Text("who visited ur profile",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.black),
                ),
                onPressed: () => _showSettingsPanel(),
              ),
            ],
          ),
          SizedBox(height: 10.0,),

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
                  'Post views :',
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
  void _showSettingsPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: ProfileVisits(),
      );
    });
  }

 */