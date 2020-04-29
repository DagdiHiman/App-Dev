import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/edit_profile.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/post.dart';
import 'package:fluttershare/widgets/post_tile.dart';
import 'package:fluttershare/widgets/progress.dart';

class Profile extends StatefulWidget {

  final String profileId;
  Profile({ this.profileId });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final String currentUserId = currentUser?.id;
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];
  String postOrientation = "grid";
  bool isFollowing = false;
  int followerCount = 0;
  int followingCount = 0;

  @override
  initState() {
    super.initState();
    getProfilePosts();
    getFollowers();
    getFollowing();
    checkIfFollowing();
  }
  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef
        .document(widget.profileId)
        .collection('userFollowers')
        .getDocuments();
    setState(() {
      followerCount = snapshot.documents.length;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followersRef
        .document(widget.profileId)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingCount = snapshot.documents.length;
    });
  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot snapshot = await postRef.document(widget.profileId)
      .collection('userPosts')
      .orderBy('timestamp', descending: true)
      .getDocuments();

    setState(() {
      isLoading = false;
      postCount = snapshot.documents.length;
      posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 15.0, color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserId)
        )
    );
  }

  Container buildButton({String text, Function function}){
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        splashColor: Colors.purpleAccent[100],
        onPressed: function,
        child: Container(
          width: 230.0,
          height: 27.0,
          child: Text(
            text,
            style: TextStyle(
              color: isFollowing ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isFollowing ? Colors.white :Colors.pinkAccent,
            border: Border.all(
              color: isFollowing? Colors.black :Colors.pink[900],
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  buildProfileButton() {
    //OWN PROFILE:
    bool isProfileOwner = currentUserId == widget.profileId;
    if(isProfileOwner){
      return buildButton(
        text: "Edit Profile",
        function: editProfile,
      );
    }
    else if (isFollowing) {
      return buildButton(text: 'Unfollow', function: handleUnfollowUser);
    }
    else if (! isFollowing) {
      return buildButton(text: 'Follow', function: handleFollowUser);
    }
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    followersRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .delete();
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(widget.profileId)
        .delete();
    activityFeedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .delete();
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    followersRef
      .document(widget.profileId)
      .collection('userFollowers')
      .document(currentUserId)
      .setData({ });
    followingRef
      .document(currentUserId)
      .collection('userFollowing')
      .document(widget.profileId)
      .setData({ });
    activityFeedRef
      .document(widget.profileId)
      .collection('feedItems')
      .document(currentUserId)
      .setData({
        'type' : 'follow',
        'ownerId' : widget.profileId,
        'username' : currentUser.username,
        'userId' : currentUserId,
        'userProfileImg' : currentUser.photoUrl,
        'timestamp' : timestamp,
    });
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: userRef.document(widget.profileId).get(),
      // ignore: missing_return
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.teal,
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            buildCountColumn("Posts", postCount),
                            buildCountColumn("Followers", followerCount),
                            buildCountColumn("Following", followingCount),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildProfileButton()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                child: Text(
                  user.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(5, 4, 0, 0),
                child: Text(
                  user.displayName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(5, 2, 0, 0),
                child: Text(
                  user.bio,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              )

            ],
          ),
        );
      },
    );
  }

  buildProfilePosts() {
    if(isLoading) {
      circularProgress();
    }
    else if (posts.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SvgPicture.asset("assets/images/no_content.svg", height: 260.0,),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "No posts",
                style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 46.0,
                    fontFamily: 'Signatra'
                ),
              ),
            ),
          ],
        ),
      );
    }

    else if ( postOrientation == 'grid'){
      List<GridTile> gridTiles = [];
      posts.forEach((post) {
        gridTiles.add(GridTile(child: PostTile(post),));
      });
      return GridView.count(crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTiles,
      );
    }

    else if(postOrientation == "list"){
      return Column(
        children: posts,
      );
    }


  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }

  buildTogglePostOrientation() {
    return Column(
      children: <Widget>[
        Divider(height: 0.0,color: Colors.pinkAccent[100],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.grid_on),
              color: postOrientation == "grid" ? Colors.pink : Colors.grey,
              splashColor: Colors.white,
              iconSize: 27.0,
              onPressed: () => setPostOrientation(postOrientation="grid"),
            ),
            IconButton(
              icon: Icon(Icons.format_list_bulleted),
              color: postOrientation == "list" ? Colors.pink : Colors.grey,
              iconSize: 30.0,
              splashColor: Colors.white,
              onPressed: () => setPostOrientation(postOrientation="list"),
            ),
          ],
        ),
        Divider(height: 0.0,color: Colors.pinkAccent[100],),
        SizedBox(height: 5.0,)
      ],
    );
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText : "Profile"),
      body: ListView(
        children: <Widget>[
          buildProfileHeader(),
          buildTogglePostOrientation(),
          Divider(
            height: 0.0,
          ),
          buildProfilePosts(),
        ],
      ),
    );
  }
}
