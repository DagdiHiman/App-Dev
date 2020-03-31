import 'package:ninja/models/user.dart';
import 'package:ninja/screens/authenticate/authenticate.dart';
import 'package:ninja/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
     final user = Provider.of<User>(context);
     print(user);

    // return either the Home or Authenticate widget
    return Authenticate();
    
  }
}