import 'package:flutter/material.dart';
import 'package:tracker/main.dart';
class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> pageChildren(double width) {

    // final size = MediaQuery.of(context).size;
    // double localX = 0;
    // double localY = 0;
    // bool defaultPosition = true;
    // double percentageX = (localX / (size.width - 40)) * 100;
    // double percentageY = (localY / 230) * 100;

    return <Widget>[
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "CORONA VIRUS\nLIVE TRACKER",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "The disease causes respiratory illness (like the flu) with symptoms such as a cough, fever, and in more severe cases, difficulty breathing. You can protect yourself by washing your hands frequently, avoiding touching your face, and avoiding close contact (1 meter or 3 feet) with people who are unwell.",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: Text(
                  "Our Packages",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),

            Text("HIMANSHU", style: TextStyle(color: Colors.white),),
              
              // GestureDetector(
              //   onPanCancel: () => setState(() => defaultPosition = true),
              //   onPanDown: (_) => setState(() => defaultPosition = false),
              //   onPanEnd: (_) => setState(() {
              //     localY = 115;
              //     localX = (size.width - 40) / 2;
              //     defaultPosition = true;
              //   }),
              //   onPanUpdate: (details) {
              //     if (mounted) setState(() => defaultPosition = false);
              //     if (details.localPosition.dx > 0 &&
              //         details.localPosition.dy < 230) {
              //       if (details.localPosition.dx < size.width - 40 &&
              //           details.localPosition.dy > 0) {
              //         localX = details.localPosition.dx;
              //         localY = details.localPosition.dy;
              //       }
              //     }
              //   }
              // ),
              // Transform(
              //   transform: Matrix4.identity()
              //     ..setEntry(3, 2, 0.001)
              //     ..rotateX(defaultPosition ? 0 : (0.3 * (percentageY / 50) + -0.3))
              //     ..rotateY(defaultPosition ? 0 : (-0.3 * (percentageX / 50) + 0.3)),
              //   alignment: FractionalOffset.center,
              //   child: Container(
              //     child: Text("Himan",style: TextStyle(color: Colors.white),),
              //   ), // back layer
              // ),

          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Image.asset(
          "images/corona.png",
          width: width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pageChildren(constraints.biggest.width / 2),
          );
        } else {
          return Column(
            children: pageChildren(constraints.biggest.width),
          );
        }
      },
    );
  }
}