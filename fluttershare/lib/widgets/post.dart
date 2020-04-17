import 'dart:async';
//import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/comments.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/pages/settings_form.dart';
import 'package:fluttershare/widgets/custom_image.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:fluttershare/pages/home.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  final dynamic likes;
  final dynamic pcount;

  Post({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.likes,
    this.pcount,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
      pcount: doc['pcount'],
    );
  }

  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  int getPCount(pcount) {
    // if no pcount, return 0
    if (pcount == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    pcount.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  getProfileCount() async{
    int count;
    DocumentSnapshot doc = await postRef.document(ownerId)
        .collection('userPosts')
        .document(postId)
        .get();
    count = doc['profileCount'];
    return count;

  }

  @override
  _PostState createState() => _PostState(
    postId: this.postId,
    ownerId: this.ownerId,
    username: this.username,
    location: this.location,
    description: this.description,
    mediaUrl: this.mediaUrl,
    likes: this.likes,
    likeCount: getLikeCount(this.likes),
    pcount : this.pcount,
    newPCount : getPCount(this.pcount),
    //profileCount: getProfileCount(),
  );
}

class _PostState extends State<Post> {

  final String currentUserId = currentUser?.id;
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  int likeCount;
  int newPCount;
  //int profileCount;
  Map likes;
  Map pcount;
  bool isLiked;
  bool showHeart = false;

  _PostState({
    this.postId,
    this.ownerId,
    this.username,
    this.location,
    this.description,
    this.mediaUrl,
    this.likes,
    this.likeCount,
    this.pcount,
    this.newPCount,
    //this.profileCount,
  });

  buildPostHeader() {
    return FutureBuilder(
      future: userRef.document(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        bool isPostOwner = currentUserId == ownerId;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            backgroundColor: Colors.grey,
          ),
          title: GestureDetector(
            onTap: () => showProfile(context, profileId: user.id),
            child: Text(
              user.username,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(location),
          trailing: isPostOwner ? IconButton(
            onPressed: () => handleDeletePost(context),
            icon: Icon(Icons.more_vert),
          ) : Text(""),
        );
      },
    );
  }

  handleDeletePost(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(title: Text(
              "remove this post ..?"
          ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {Navigator.pop(context);
                deletePost();
                },
                child: Text('Delete', style: TextStyle(color: Colors.red),),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.grey),),
              )
            ],
          );
        }
    );
  }

  deletePost() async {
    postRef
        .document(ownerId)
        .collection('userPosts')
        .document(postId)
        .get().then((doc) {
      if(doc.exists) {
        doc.reference.delete();
      }
    });

    storageRef.child("post_$postId.jpg").delete();

    QuerySnapshot activityFeedSnapshot = await activityFeedRef
        .document(ownerId)
        .collection('feedItems')
        .where('postId', isEqualTo: postId)
        .getDocuments();

    activityFeedSnapshot.documents.forEach((doc) {
      if(doc.exists){
        doc.reference.delete();
      }
    });

    QuerySnapshot commentSnapshot = await commentsRef
        .document(postId)
        .collection('comments')
        .getDocuments();

    commentSnapshot.documents.forEach((doc) {
      if(doc.exists){
        doc.reference.delete();
      }
    });
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;
    if(_isLiked) {
      postRef.document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({ 'likes.$currentUserId' : false });
      removeLikeFromActivityFeed();
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked){
      postRef.document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({ 'likes.$currentUserId' : true });
      addLikeToActivityFeed();
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 500),() {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  removeLikeFromActivityFeed() {
    bool isNotPostOwner = currentUserId != ownerId;
    if(isNotPostOwner) {
      activityFeedRef
          .document(ownerId)
          .collection("feed")
          .document(postId)
          .get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }
  }

  addLikeToActivityFeed() {

    bool isNotPostOwner = currentUserId != ownerId;
    if(isNotPostOwner){
      activityFeedRef
          .document(ownerId)
          .collection("feed")
          .document(postId)
          .setData({
        "type" : "like",
        "username" : currentUser.username,
        "userId" : currentUser.id,
        "postId" : postId,
        "mediaUrl" : mediaUrl,
        "userProfileImg" : currentUser.photoUrl,
        "timestamp" : timestamp,
      });
    }
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: handleLikePost,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //Image.network(mediaUrl),
          cachedNetworkImage(mediaUrl),

          showHeart ?
          Icon(Icons.favorite, size: 80.0, color: Colors.red[700],)
//          Animator(
//            duration: Duration(milliseconds: 300),
//            tween: Tween(begin: 0.8, end: 1.6),
//            curve: Curves.bounceOut,
//            cycles: 0,
//            builder: (anim) => Transform.scale(scale: anim.value,
//              child: Icon(Icons.favorite, size: 80.0, color: Colors.red[700],),
//            ) ,
//          )
        : Text(""),
        ],
      ),
    );
  }

  void _showSettingsPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
        child: SettingsForm(userId: currentUserId, postId: postId,),
      );
    });
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
                children : <Widget>[
                  Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                  GestureDetector(
                    onTap: handleLikePost,
                    child: Icon(
                      isLiked ? Icons.favorite :Icons.favorite_border,
                      size: 28.0,
                      color: Colors.pink,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20.0)),
                  GestureDetector(
                    onTap: () => showComments(
                      context,
                      postId: postId,
                      ownerId: ownerId,
                      mediaUrl: mediaUrl,
                    ),
                    child: Icon(
                      Icons.chat,
                      size: 28.0,
                      color: Colors.blue[900],
                    ),
                  ),
                ]),
            currentUserId == ownerId ? Row(
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.graphic_eq, color: Colors.black,size: 25.0,),
                  label: Text("Insights",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,color: Colors.black),
                  ),
                  onPressed: () => _showSettingsPanel(),
                ),
              ],
            ) : Text(''),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$username ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: Text(description))
          ],
        ),
      ],
    );
  }


  showProfile(BuildContext context, {String profileId}) async {
    print('+1 profile view');
    print(profileId);
    print(ownerId);
    print(currentUserId);
    print(currentUser.id);
    print(currentUser.displayName);
    print(postId);
    print(timestamp);
    String cudn = currentUser.displayName;
    print(cudn);
    print('-1');

    postRef.document(ownerId)
        .collection('userPosts')
        .document(postId)
        .updateData({ 'pcount.$cudn' : timestamp });

//    DocumentSnapshot doc = await postRef.document(ownerId)
//        .collection('userPosts')
//        .document(postId)
//        .get();
//    print("$doc['profileCount']");

      Firestore.instance.
      collection('posts').
      document(profileId).
      collection('userPosts').
      document(postId).
      updateData({
        'profileCount': FieldValue.increment(1),
      });

//    setState(() {
//      //profileCount += 1;
//    });
//    postRef.document(ownerId)
//        .collection('userPosts')
//        .document(postId)
//        .updateData({ 'profileCount' : 1 });


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(
          profileId: profileId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    isLiked = (likes[currentUserId]== true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter()
      ],
    );
  }
}

showComments(BuildContext context,
    {String postId, String ownerId, String mediaUrl}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
      postOwnerId: ownerId,
      postMediaUrl: mediaUrl,
    );
  }));
}
