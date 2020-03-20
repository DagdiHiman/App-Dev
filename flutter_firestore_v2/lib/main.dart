import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'newtask.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: CreatToDo(),
    );
  }
}

class CreatToDo extends StatefulWidget {
  @override
  _CreatToDoState createState() => _CreatToDoState();
}

class _CreatToDoState extends State<CreatToDo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _myAppBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[400],
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.black,
          size: 40.0,
        ),
        onPressed: () {
          Navigator.push(context,
           MaterialPageRoute(
             builder: (context) => NewTask(),
             fullscreenDialog: true
           ),
          );
        },
      ),
    );
  }

  Widget _myAppBar() {
    return AppBar(
      title: const Text('ToDo App',),
      backgroundColor: Colors.redAccent[400],
      centerTitle: true,
    );
  }
}
