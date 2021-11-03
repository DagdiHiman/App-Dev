/// Cred Assignment - offers screen

import 'package:flutter/material.dart';
import './loaders/color_loader_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'dart:math' as Math;
import 'package:async/async.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());
var url_s = Uri.https('api.mocklets.com', '/p68348/success_case');
var url_f = Uri.https('api.mocklets.com', '/p68348/failure_case');

Future<Data> apiCall(var url) async {
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var success = jsonResponse['success'];
    print('SUCCESS: $success');
  } else {
    print('Request failed with status: ${response.statusCode}.');
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var failed = jsonResponse['success'];
    print('FAILED: $failed');
  }
  return Data.fromJson(convert.jsonDecode(response.body));
  // return jsonResponse;
}

class Data {
  final bool status;
  final String statusString;

  Data({this.status = false, this.statusString = 'FAILED'});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      status: json['success'],
      statusString: json['success'] == true ? 'SUCCESS' : 'FAILED',
    );
  }
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'CRED Assignment';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: const Color(0xFF28282B)), //363233
      home: Scaffold(
        // appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //     title: const Center(child: Text(_title))),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  bool hideDraggable = false, expandOffer = false;
  var apiStatus;
  String res = '', gifName = '';
  Future<Data>? apiData;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  // late final AnimationController _controller = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 3),
  // )..repeat(reverse: true);

  // late final Animation<double> _animation = Tween<double>(
  //   begin: 0.0,
  //   end: 16.0,
  // ).animate(_controller);

  @override
  void initState() {
    super.initState();
    apiData = apiCall(url_s);
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(fit: StackFit.loose, clipBehavior: Clip.hardEdge, children: <
        Widget>[
      AnimatedPositioned(
        duration: const Duration(milliseconds: 600),
        height: expandOffer ? 0 : 100,
        width: expandOffer ? 0 : width * 1,
        curve: Curves.bounceOut,
        child: expandOffer
            ? const Text('')
            : Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    // color: Colors.red,
                    child: TextButton(
                      child: Text(
                        'FAILURE CASE',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 15,
                          color: Colors.redAccent[200],
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          print('failed case');
                          apiData = apiCall(url_f);
                        });
                        Fluttertoast.showToast(
                            msg: "Activated Failed Case",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                    ),
                  ),
                ),
              ),
      ),
      AnimatedPositioned(
        duration: const Duration(milliseconds: 700),
        height: expandOffer ? height * 0.96 : height * 0.54,
        width: width * 1,
        child: Padding(
          padding: EdgeInsets.only(
              top: height * 0.12, left: width * 0.04, right: width * 0.04),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 4.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: expandOffer && hideDraggable
                ? ListView(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              res,
                              style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            res.isNotEmpty
                                ? Image.asset(
                                    "assets/$gifName", //$gifName
                                    height: 200.0,
                                    width: 200.0,
                                  )
                                : const Text(''),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Text(''),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: height * 0.04),
          child: Container(
            height: height * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // The following example has a [Draggable] widget along with a [DragTarget]
                // in a row demonstrating an incremented `acceptedData` integer value when
                // you drag the element to the target.
                Draggable<int>(
                  data: 10,
                  axis: Axis.vertical,
                  child: hideDraggable
                      ? const SizedBox(
                          height: 100.0,
                          width: 100.0,
                        )
                      : TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 2000),
                          tween: Tween<double>(begin: 0.0, end: 8.0),
                          builder: (BuildContext context, dynamic value,
                              Widget? child) {
                            return Padding(
                              padding: EdgeInsets.only(top: value),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/cred_logo.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle),
                                height: 100.0,
                                width: 100.0,
                              ),
                            );
                          },
                        ),
                  feedback: LimitedBox(
                    maxHeight: 400.0,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/cred_logo.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  childWhenDragging: const SizedBox(
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                Center(
                  child: hideDraggable
                      ? const SizedBox(
                          height: 100.0,
                          width: 100.0,
                        )
                      : Transform.rotate(
                          angle: Math.pi,
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/arrow2.gif",
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),
                ),
                DragTarget<int>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return !hideDraggable
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 0.0, /*_animation.value*/
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              height: 100.0,
                              width: 100.0,
                            ),
                          )
                        : FutureBuilder<Data>(
                            future: apiData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _fetchData() {
                                  return _memoizer.runOnce(() async {
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    setState(() {
                                      res = snapshot.data!.statusString;
                                      print('HERE>>>>');
                                      gifName = res == 'SUCCESS'
                                          ? 'yay.gif'
                                          : 'nah.gif';
                                      print('gifName:' + gifName);
                                    });

                                    return res;
                                  });
                                }

                                _fetchData();
                                return const Text('');
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              } else {
                                return ColorLoader2(
                                  color1: Colors.redAccent,
                                  color2: Colors.deepPurple,
                                  color3: Colors.green,
                                );
                              }
                            },
                          );
                  },
                  onAccept: (int data) {
                    setState(() {
                      hideDraggable = true;
                      expandOffer = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
