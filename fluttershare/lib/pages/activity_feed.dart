import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/pages/post_screen.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/pages/search.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  getActivityFeed() async {
    QuerySnapshot snapshot = await activityFeedRef
        .document(currentUser.id)
        .collection('feedItems')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .getDocuments();
    List<ActivityFeedItem> feedItems = [];
    snapshot.documents.forEach((doc) {
      feedItems.add(ActivityFeedItem.fromDocument(doc));
      // print('Activity Feed Item: ${doc.data}');
    });
    return feedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Colors.pinkAccent[100],
                Colors.purpleAccent[100],
                Colors.blueAccent[100],
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 0.7, 0.9],
              ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(titleText: "Activity Feed"),
        body: Container(
            child: FutureBuilder(
              future: getActivityFeed(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return circularProgress();
                }
                return ListView(
                  children: snapshot.data,
                );
              },
            )),
      ),
    );
  }
}

Widget mediaPreview;
String activityItemText;

class ActivityFeedItem extends StatefulWidget {
  final String username;
  final String userId;
  final String type; // 'like', 'follow', 'comment'
  final String mediaUrl;
  final String postId;
  final String userProfileImg;
  final String commentData;
  final Timestamp timestamp;

  ActivityFeedItem({
    this.username,
    this.userId,
    this.type,
    this.mediaUrl,
    this.postId,
    this.userProfileImg,
    this.commentData,
    this.timestamp,
  });

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItem(
      username: doc['username'],
      userId: doc['userId'],
      type: doc['type'],
      postId: doc['postId'],
      userProfileImg: doc['userProfileImg'],
      commentData: doc['commentData'],
      timestamp: doc['timestamp'],
      mediaUrl: doc['mediaUrl'],
    );
  }

  @override
  _ActivityFeedItemState createState() => _ActivityFeedItemState();
}

class _ActivityFeedItemState extends State<ActivityFeedItem> {
  showPost(context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            PostScreen(postId: widget.postId, userId: widget.userId,)
    ));
  }

  configureMediaPreview(context) {
    if (widget.type == "like" || widget.type == 'comment') {
      mediaPreview = GestureDetector(
        onTap: () => showPost(context),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.mediaUrl),
                  ),
                ),
              )),
        ),
      );
    } else {
      mediaPreview = Text('');
    }

    if (widget.type == 'like') {
      activityItemText = "liked your post";
    } else if (widget.type == 'follow') {
      activityItemText = "is following you";
    } else if (widget.type == 'comment') {
      activityItemText = 'replied: ${widget.commentData}';
    } else {
      activityItemText = "Error: Unknown type '${widget.type}'";
    }
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        child: Container(
          color: Colors.white54,
          child: ListTile(
            title: GestureDetector(
              onTap: () => showProfile(context, profileId: widget.userId),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: widget.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' $activityItemText',
                      ),
                    ]),
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  widget.userProfileImg),
            ),
            subtitle: Text(
              timeago.format(widget.timestamp.toDate()),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: mediaPreview,
          ),

        ),
      ),
    );
  }
}