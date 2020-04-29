import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/pages/search.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/post.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:fluttershare/widgets/stories_list.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  final User currentUser;

  Timeline({this.currentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Post> posts;
  List<String> followingList = [];

  @override
  void initState() {
    super.initState();
    getTimeline();
    getFollowing();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .document(widget.currentUser.id)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
    snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(currentUser.id)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingList = snapshot.documents.map((doc) => doc.documentID).toList();
    });
  }

  ///////////////

  Widget _horizontalListView() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => _buildBox(color: Colors.orange),
      ),
    );
  }

  Widget _buildBox({Color color}) => Container(margin: EdgeInsets.all(12), height: 100, width: 200, color: color);

  /////////////

  buildTimeline() {
    if (posts == null) {
      return circularProgress();
    } else if (posts.isEmpty) {
      return buildUsersToFollow();
    } else {
      //return ListView(children: posts);
      return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //_horizontalListView(),
                Container(
                  padding: EdgeInsets.all(5.0),
                  height: 100.0 ,
                  child: StoriesList(),
                ),
                ListView(
                    children: posts,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
              ],
            ),
          ),
        ],
      );

    }
  }

  buildUsersToFollow() {
    return StreamBuilder(
      stream:
      usersRef.orderBy('timestamp', descending: true).limit(30).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser.id == user.id;
          final bool isFollowingUser = followingList.contains(user.id);
          // remove auth user from recommended list
          if (isAuthUser) {
            return;
          } else if (isFollowingUser) {
            return;
          } else {
            UserResult userResult = UserResult(user);
            userResults.add(userResult);
          }
        });
        return Container(
          color: Theme.of(context).accentColor.withOpacity(0.2),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Users to Follow",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              Column(children: userResults),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(isAppTitle: true),
        body: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () => getTimeline(), child: buildTimeline()),
            ),
          ],
        ));
  }
}


/*

1
//      return SingleChildScrollView(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            _horizontalListView(),
//
//            SizedBox(
//              height: 800,
//              child: ListView(
//                  children: posts,
//                  shrinkWrap: true,
//                ),
//            ),
//
//          ],
//        ),
//      );

2
//    return Flexible(
//      child: ListView.builder(
//        itemCount: 2,
//        itemBuilder: (_, i) {
//          if (i == 1) {
//            return Container(
//              height: 100,
//              color: Colors.blue,
//            );
//          }
//          else {
//            return SizedBox(
//                height: 400,
//                child: ListView(children: posts)
//            );
//          }
//        },
//      ),
//    );

3
//    return ListView(
//      physics: ClampingScrollPhysics(),
//      shrinkWrap: true,
//      children: <Widget>[
//        _horizontalListView(),
//        SizedBox(height:800,child: ListView(children: posts)),
//      ],
//    );


 */