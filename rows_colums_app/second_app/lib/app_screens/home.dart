import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left:10.0, top:40.0, right:10.0),
          alignment: Alignment.center,
          color: Colors.deepPurple,
          child: Column(
            children: <Widget>[
              Img(),
              Container(
              margin: EdgeInsets.only(bottom:30.0,),
              child: Row(
                children: <Widget>[
                  BluePlane(),
                  Expanded(child:Text(
                    "Indigo",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 40,
                      fontFamily: "Lato",
                    ),
                  ),
                  ),

                  Expanded(
                    child: Text(
                      "From Benguluru to Jaipur",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                ],
              ),
              ),
              Container(
              margin: EdgeInsets.only(bottom:30.0,),
              child:Row(

                children: <Widget>[
                  BluePlane(),
                  Expanded(child:Text(
                    "Spice Jet",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 40,
                      fontFamily: "Lato",
                    ),
                  ),
                  ),

                  Expanded(
                    child: Text(
                      "From Hyderabad to Mumbai",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                ],
              ),
              ),
              Btn(),

            ],
          ), 
      
      ),
    );
  }
}

class Img extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage img = AssetImage("images/plane2.png");
    Image image = Image(image: img);
    return Container(
      child:image,
      width: 150.0,
      height: 110.0,
      margin: EdgeInsets.only(bottom:100.0,),
    );
  }
}

class BluePlane extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage img = AssetImage("images/plane_blue.png");
    Image image = Image(image: img);
    return Container(
      child:image,
      width: 45.0,
      height: 35.0,
      //margin: EdgeInsets.only(right:8.0),
    );
  }
}

class Btn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:50.0),
      width: 180.0,
      height: 70.0,
      child: RaisedButton(
        color: Colors.deepOrange,
        child: Text(
          "Book Flight",
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
            fontSize: 25,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 8.0,
        onPressed: () => bookFlight(context),
      )
    );
  }
}

void bookFlight(BuildContext context){
  var alert = AlertDialog(
    title: Text("SUCCESS"),
    content: Text("Have a Pleasant Journey !"),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}