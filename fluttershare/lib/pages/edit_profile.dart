import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

class EditProfile extends StatefulWidget {

  final String currentUserId;

  EditProfile({ this.currentUserId });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  User user;
  bool isLoading = false;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool _displayNameValid = true;
  bool _bioValid = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await userRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    bioController.text = user.bio;
    displayNameController.text = user.displayName;
    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Display Name",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
            errorText: _displayNameValid ? null : "too short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Bio",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "Update your Bio",
            errorText: _bioValid ? null : "too long, max char allowed : 100",
          ),
        )
      ],
    );
  }

  updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
      displayNameController.text.isEmpty ? _displayNameValid = false :
          _displayNameValid = true;
      bioController.text.trim().length > 100 ? _bioValid = false :
          _bioValid = true;
    });

    if(_displayNameValid && _bioValid) {
      userRef.document(widget.currentUserId).updateData({
        "displayName" :displayNameController.text,
        "bio" : bioController.text,
      });
      SnackBar snackbar = SnackBar(content: Text("Profile Updated !"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Future.delayed(const Duration(milliseconds: 750), () {
        setState(() {
          Navigator.pop(context);
        });
      });
    }
  }

  logout() async{
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(titleText : "Edit Profile", removeBackButton: true),
      body: isLoading ? circularProgress() :
          ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 50.0,
                        backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          buildDisplayNameField(),
                          buildBioField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      onPressed: updateProfileData,
                      child: Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      elevation: 8.0,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.white)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FlatButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(55.0),
                            side: BorderSide(color: Colors.red)
                        ),
                        splashColor: Colors.black,
                        onPressed: logout,
                        label: Text('LOGOUT',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(Icons.cancel, size: 30.0, color: Colors.red,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
    );
  }
}
