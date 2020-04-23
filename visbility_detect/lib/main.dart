
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LazyLoadingPage(),
    );
  }
}

class LazyLoadingPage extends StatefulWidget {
  @override
  _LazyLoadingPageState createState() => _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {
  List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    myList = List.generate(10, (i) => "Item : ${i + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      myList.add("Item : ${i + 1}");
    }

    _currentMax = _currentMax + 10;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazy Loading"),
      ),
      body:  ListView.builder(
          controller: _scrollController,
          itemExtent: 250,
          itemCount: myList.length + 1,
          itemBuilder: (context, i) {
            if (i == myList.length) {
              return CupertinoActivityIndicator();
            }
            String n = myList[i];
            return VisibilityDetector(
              key: Key("unique key"),
              onVisibilityChanged: (VisibilityInfo info) {
                //print('type of n: ${n.runtimeType}');
                //var visiblePercentage = info.visibleFraction * 100;
                //print('type of %: ${visiblePercentage.runtimeType}');
                //debugPrint('1: Widget ${info.key} is ${visiblePercentage.toInt()}% visible');
                //debugPrint("${visiblePercentage.toInt()}% of $n is visible ");
              },
              child: Column(
                children: <Widget>[
                  Divider(
                    thickness: 2.0,
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.blue[100],
                    child: VisibilityDetector(
                      key: Key("unique key"),
                      onVisibilityChanged: (VisibilityInfo info) {
                        var visiblePercentage = info.visibleFraction * 100;
                        debugPrint("=> ${visiblePercentage.toInt()}% of $n is visible ");
                      },
                      child: ListTile(
                        title: Text(myList[i]),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.red,
                  )
                ],
              ),
            );
          },
        ),
    );
  }
}