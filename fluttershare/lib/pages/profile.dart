import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: header(titleText : "Profile"),
      body: linearProgress(),
    );
  }
}
