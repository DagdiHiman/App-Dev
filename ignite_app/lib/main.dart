
import 'package:flutter/material.dart';
import 'package:third_app/detailsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() =>    _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left:10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {},
                ),
                Container(
                  width: 125,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {},
                      )
                    ],
                  )
                )
              ],
            )
          ),

          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0) ,
            child: Row(
              children: <Widget>[
                Text('IGNITE',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  )
                ),
                SizedBox(width: 10,),
                Text('Fest',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 30,
                  ),
                )
              ]
            )
          ),

          SizedBox( height: 5.0, ),
          Padding(
            padding: EdgeInsets.only(left: 40.0) ,
            child: Row(
              children: <Widget>[
                Text('Event Registrations',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black45,
                    decoration: TextDecoration.underline,
                    fontSize: 17.0,
                  )
                ),
              ]
            )
          ),

          SizedBox(height: 40.0,),
          Container(
            height: MediaQuery.of(context).size.height - 185.0 ,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25, right: 20),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 45),
                  child: Container(
                    height: MediaQuery.of(context).size.height-300,
                    child: ListView(
                      children: [
                        _buildFootItem('images/hunt1.png', 'Treasure Hunt', 'Rs 50.0',context),
                        _buildFootItem('images/code2.png', 'Competitive Coding', 'Rs 40.0',context),
                        _buildFootItem('images/ipl1.png', 'Mock IPL Auction', 'Rs 80.0',context),
                        _buildFootItem('images/chess1.png', 'Chess Blitz', 'Rs 20.0',context),
                        _buildFootItem('images/pubg1.png', 'PUBG', 'Rs 50.0',context),
                        _buildFootItem('images/cs1.png', 'CS:GO', 'Rs 50.0',context),
                        _buildFootItem('images/gre2.png', 'Mock GRE', 'Rs 60.0',context),
                        _buildFootItem('images/int1.png', 'Mock Interview', 'Rs 100.0',context),
                      ]
                    ),
                  )
                ),

                Center(child: 
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom:5) ,
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 65.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Icon(Icons.search, color: Colors.black),
                                ),
                              ),
                              Container(
                                height: 65.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Icon(Icons.shopping_basket, color: Colors.black),
                                ),
                              ),
                              Container(
                                height: 65.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFF1C1428)),
                                child: Center(
                                    child: Text('Checkout',
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            color: Colors.white,
                                            fontSize: 20.0))),
                              )
                            ],
                          ),
                  )
                ),
                
              ],
            ),
          )

        ],
      ),
    );
  }
}


Widget _buildFootItem(String imgPath, String eventName, String price, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
              builder: (context) => DetailsPage(heroTag: imgPath,eventName: eventName,eventPrice: price,)
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: [
                Hero(
                  tag: imgPath,
                  child: Image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 75.0,
                    width: 75.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      eventName,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    )
                  ]
                )
              ],
            )
          ),

          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {},
          )

        ],
      ),
    )
  );
}