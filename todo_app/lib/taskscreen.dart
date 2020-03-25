import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task.dart';
import 'firestoreservice.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  TaskScreen(this.task);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

Widget _myAppBar() {
    return AppBar(
      title: const Text(
        'Basic AppBar',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
    );
  }

class _TaskScreenState extends State<TaskScreen> {
  FirestoreService fireServ = new FirestoreService();

  TextEditingController _taskNameController;
  TextEditingController _taskDetailsController;
  TextEditingController _taskDateController;
  TextEditingController _taskTimeController;

  int _myTaskType = 0;
  String taskVal;
  void _handleTaskType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
         taskVal='travel';
          break;
        case 2:
           taskVal='shopping';
          break;
        case 3:
           taskVal='gym';
          break;
        case 4:
           taskVal='party';
          break;
        case 5:
           taskVal='others';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _taskNameController = new TextEditingController(text: widget.task.taskname);
    _taskDetailsController = new TextEditingController(text: widget.task.taskdetails);
    _taskDateController = new TextEditingController(text: widget.task.taskdate);
    _taskTimeController = new TextEditingController(text: widget.task.tasktime);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            color: Colors.lightBlue[50],
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(labelText: "Task: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskDetailsController,
                    decoration: InputDecoration(labelText: "Details: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskDateController,
                    decoration: InputDecoration(labelText: "Date: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskTimeController,
                    decoration: InputDecoration(labelText: "Time: "),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'Select Task Type:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.blueAccent[400],
                        ),
                        Text(
                          'Travel',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.pinkAccent[400],
                        ),
                        Text(
                          'Shopping',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.greenAccent[400],
                        ),
                        Text(
                          'Gym',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.purpleAccent[400],
                        ),
                        Text(
                          'Party',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.yellow[800],
                        ),
                        Text(
                          'Others',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.indigo[700],
                        textColor: Colors.white,
                        child: Text("Cancel".toUpperCase(),
                          style: TextStyle(fontSize: 19, fontFamily: 'Lato')),
                      ),

                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          fireServ.createTODOtask(_taskNameController.text, _taskDetailsController.text,_taskDateController.text,_taskTimeController.text,taskVal).then((_) {
                           Navigator.pop(context);
                          });
                        },
                        color: Colors.indigo[700],
                        textColor: Colors.white,
                        child: Text("Submit".toUpperCase(),
                          style: TextStyle(fontSize: 19, fontFamily: 'Roboto')),
                      ),
                
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /*Widget _myAppBar() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFFFA7397),
              const Color(0xFFFDDE42),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'New Tasks',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }*/
}