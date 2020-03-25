import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewTask extends StatefulWidget {
  NewTask();
  @override
  _NewTaskState createState() => _NewTaskState();
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

class _NewTaskState extends State<NewTask> {
  String taskName, taskDetails, taskDate, taskTime;

  getTaskName(taskName) {
    this.taskName = taskName;
  }

  getTaskDetails(taskDetails) {
    this.taskDetails = taskDetails;
  }

  getTaskDate(taskDate) {
    this.taskDate = taskDate;
  }

  getTaskTime(taskTime) {
    this.taskTime = taskTime;
  }

  int _myTaskType = 0;
  String taskVal;

  void _handleTaskType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          taskVal = 'travel';
          break;
        case 2:
          taskVal = 'shopping';
          break;
        case 3:
          taskVal = 'gym';
          break;
        case 4:
          taskVal = 'party';
          break;
        case 5:
          taskVal = 'others';
          break;
      }
    });
  }

    createData(){
      DocumentReference ds=Firestore.instance.collection('todolist').document(taskName);
      Map<String,dynamic> tasks={
        "taskname":taskName,
        "taskdetails":taskDetails,
        "taskdate":taskDate,
        "tasktype":taskVal,
        "tasktime":taskTime,
      };

      ds.setData(tasks).whenComplete((){
        print("task updated");
      });
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
                    onChanged: (String name) {
                      getTaskName(name);
                    },
                    decoration: InputDecoration(labelText: "Task :"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String name) {
                      getTaskDetails(name);
                    },
                    decoration: InputDecoration(labelText: "Details :"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String name) {
                      getTaskDate(name);
                    },
                    decoration: InputDecoration(labelText: "Date :"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String name) {
                      getTaskTime(name);
                    },
                    decoration: InputDecoration(labelText: "Time :"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'Select Task Type:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
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
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Colors.pinkAccent[400],
                          ),
                          Text(
                            'Shopping',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      Row(
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
                    ]),
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
                          createData();
                        },
                        color: Colors.indigo[700],
                        textColor: Colors.white,
                        child: Text("Submit".toUpperCase(),
                          style: TextStyle(fontSize: 19, fontFamily: 'Roboto')),
                      ),

                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
