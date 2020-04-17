import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'home.dart';

class ProfileVisits extends StatelessWidget {

  final String userId;
  final String postId;
  String name;
  int timestamp;

  ProfileVisits({this.userId, this.postId, this.name, this.timestamp });

  @override
  Widget build(BuildContext context) {

    print(userId);
    print(postId);
    print('DONE');



    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.0),
          boxShadow: [BoxShadow(
            color: Colors.pink,
            offset: Offset(9,9),
            blurRadius: 4.0,
          )]
      ),
      child: StreamBuilder(
        stream: postRef
            .document(userId)
            .collection('userPosts')
            .document(postId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
//        print(snapshot.data.runtimeType);
//        Post post = Post.fromDocument(snapshot.data);
//        print(snapshot.data.runtimeType);

//          var list = [];
//          print('BEGINNING......');
//          var docmap = snapshot.data['pcount'].forEach((k, v)
//          {
//            print('KEY: $k');
//            print('Value: $v');
//            list.add([k,v]);
//          });
//          print('END');
//          print(list);
//          print('END............');

          Map<String,dynamic> myMap = Map.from( snapshot.data['pcount'] );
          print('MAP:');
          print(myMap);
          String key = snapshot.data['pcount'].keys.elementAt(0);
          print('KEY0 : $key');
          print(snapshot.data['pcount'][key].toString());
          print('DONE');

          return Center(
            child: Scaffold(
              appBar: header( titleText: 'Latest Visits ToProfile' ,removeBackButton: true),
              body: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent
                    ),
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Profile Visits :', style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(snapshot.data['profileCount'].toString(), style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Divider(height:10.0, color: Colors.black,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Unique Profile Viewers :', style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(snapshot.data['pcount'].length.toString(), style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  Divider(height:10.0, color: Colors.black,),

                  Flexible(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data['pcount'].length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = snapshot.data['pcount'].keys.elementAt(index);
                          Timestamp kv = snapshot.data['pcount'][key];
                          String kvs = timeago.format(kv.toDate());
                              //timeago.format(timestamp.toDate())
                          return new Column(
                            children: <Widget>[
                              new ListTile(
                                title: new Text("$key",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                                ),
                                subtitle: new Text("$kvs",
                                  style: TextStyle(fontSize: 16.0, color: Colors.blueGrey[700]),
                                ),
                              ),
                              new Divider(
                                height: 2.0,
                              ),
                            ],
                          );
                        },
                      ),
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
