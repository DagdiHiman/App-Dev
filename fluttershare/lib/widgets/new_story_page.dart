import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';

class NewStoryPage extends StatefulWidget {
  @override
  _NewStoryPageState createState() => _NewStoryPageState();
}

class _NewStoryPageState extends State<NewStoryPage> {
  static String collectionDbName = 'instagram_stories_db';

  //TODO: add possibility get data from any API
  CollectionReference dbInstance =
  Firestore.instance.collection(collectionDbName);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter instagram stories"),
      ),
      body: Column(
        children: <Widget>[
          FlutterInstagramStories(
            collectionDbName: collectionDbName,
            showTitleOnIcon: true,
            backFromStories: () {
              _backFromStoriesAlert();
            },
            iconTextStyle: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
            iconImageBorderRadius: BorderRadius.circular(15.0),
            iconBoxDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: Color(0xFFffffff),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff333333),
                  blurRadius: 10.0,
                  offset: Offset(
                    0.0,
                    4.0,
                  ),
                ),
              ],
            ),
            iconWidth: 150.0,
            iconHeight: 150.0,
            textInIconPadding:
            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
            //how long story lasts in seconds
            imageStoryDuration: 7,
            progressPosition: ProgressPosition.top,
            repeat: true,
            inline: false,
            languageCode: 'en',
            backgroundColorBetweenStories: Colors.black,
            closeButtonIcon: Icon(
              Icons.close,
              color: Colors.white,
              size: 28.0,
            ),
            closeButtonBackgroundColor: Color(0x11000000),
            sortingOrderDesc: true,
            lastIconHighlight: true,
            lastIconHighlightColor: Colors.deepOrange,
            lastIconHighlightRadius: const Radius.circular(15.0),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "App's functuonality",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _backFromStoriesAlert() {
    showDialog(
      context: context,
      child: SimpleDialog(
        title: Text(
          "User have looked stories and closed them.",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: Text("Dismiss"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}