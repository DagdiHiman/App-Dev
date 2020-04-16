import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/post.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'home.dart';

class ProfileVisits extends StatelessWidget {

  final String userId;
  final String postId;

  ProfileVisits({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {

    print(userId);
    print(postId);
    print('DONE');
    profilecounts();

    return Center(
      child: Scaffold(
        appBar: header( titleText: 'Latest Visits ToProfile' ,removeBackButton: true),
        body: ListView(
          children: <Widget>[
            Container(
              //child: post,
            )
          ],
        ),
      ),
    );

//    return FutureBuilder(
//      future: postRef
//          .document(userId)
//          .collection('userPosts')
//          .document(postId)
//          .get(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return circularProgress();
//        }
//        print(snapshot.data.runtimeType);
//        Post post = Post.fromDocument(snapshot.data);
//        print(snapshot.data.runtimeType);
//
//      },
//    );
  }
  profilecounts() async {
    var doc = await postRef
        .document(userId)
        .collection('userPosts')
        .document(postId)
        .get();

    print(doc);
    print(doc.runtimeType);
    print(doc['profileCount']);

  }
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


/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/progress.dart';

import 'home.dart';

class ProfileVisits extends StatefulWidget {

  final String postId;
  final String ownerId;
  final String username;
  final int profileCount;

  ProfileVisits({
    this.postId,
    this.ownerId,
    this.username,
    this.profileCount,
  });

  factory ProfileVisits.fromDocument(DocumentSnapshot doc) {
    return ProfileVisits(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      profileCount: doc['profileCount'],
    );
  }

  @override
  _ProfileVisitsState createState() => _ProfileVisitsState(
    postId: this.postId,
    ownerId: this.ownerId,
    username: this.username,
    profileCount: this.profileCount,
  );
}

class _ProfileVisitsState extends State<ProfileVisits> {

  final String postId;
  final String ownerId;
  final String username;
  final int profileCount;

  _ProfileVisitsState({
    this.postId,
    this.ownerId,
    this.username,
    this.profileCount,
  });


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
}
 */
