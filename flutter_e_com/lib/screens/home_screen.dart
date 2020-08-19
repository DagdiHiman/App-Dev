import 'package:flutter/material.dart';
import 'package:flutter_amazon_ui_redesign/models/product_model.dart';
import 'package:flutter_amazon_ui_redesign/screens/api_products.dart';
import 'package:flutter_amazon_ui_redesign/screens/cart_screen.dart';
import 'package:flutter_amazon_ui_redesign/widgets/product_carousel.dart';
import 'package:flutter_amazon_ui_redesign/widgets/responsive_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    final tabs = [
      ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              // Image(
              //   image: AssetImage('assets/images/samsung_gear_vr.jpg'),
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 350,
                height: ResponsiveWidget.isSmallScreen(context)
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/samsung_gear_vr.jpg'),
                  ),
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 30.0,
                right: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'POPULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'The future of',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'virtual reality',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: 70.0,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/gear_vr.jpg'),
                            height: 50.0,
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Samsung Gear VR',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'FOR GAMERS',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 60.0,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(10.0),
                                    onPressed: () => print('Go to product'),
                                    color: Colors.deepOrange,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15.0),
          ProductCarousel(
            title: 'Festive Deals',
            products: products,
          ),
          ProductCarousel(
            title: 'Popular Books',
            products: books,
          ),
        ],
      ),
      CartScreen(),
      HttpScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.orangeAccent[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: InkResponse(
            onTap: () => print('Menu'),
            child: Icon(
              Icons.menu,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ),
        title: Image(
          image: AssetImage(''),
          height: 30.0,
        ),
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12.0, right: 20.0),
                child: InkResponse(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(),
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_basket,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkResponse(
              onTap: () => print('Search'),
              child: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
//      body: ListView(
//        children: <Widget>[
//          Stack(
//            children: <Widget>[
//              // Image(
//              //   image: AssetImage('assets/images/samsung_gear_vr.jpg'),
//              // ),
//              Container(
//                width: MediaQuery.of(context).size.width,
//                // height: 350,
//                height: ResponsiveWidget.isSmallScreen(context)
//                    ? MediaQuery.of(context).size.height * 0.5
//                    : MediaQuery.of(context).size.width * 0.5,
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    fit: BoxFit.fill,
//                    image: AssetImage('assets/images/samsung_gear_vr.jpg'),
//                  ),
//                ),
//              ),
//              Positioned(
//                left: 20.0,
//                bottom: 30.0,
//                right: 20.0,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      'POPULAR',
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                    SizedBox(height: 10.0),
//                    Text(
//                      'The future of',
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 30.0,
//                        fontWeight: FontWeight.w500,
//                      ),
//                    ),
//                    Text(
//                      'virtual reality',
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 32.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                    SizedBox(height: 15.0),
//                    Container(
//                      padding: EdgeInsets.all(10.0),
//                      height: 70.0,
//                      width: double.infinity,
//                      color: Colors.white,
//                      child: Row(
//                        children: <Widget>[
//                          Image(
//                            image: AssetImage('assets/images/gear_vr.jpg'),
//                            height: 50.0,
//                          ),
//                          SizedBox(width: 10.0),
//                          Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text(
//                                'Samsung Gear VR',
//                                style: TextStyle(
//                                  fontSize: 18.0,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                              Text(
//                                'FOR GAMERS',
//                                style: TextStyle(
//                                  color: Colors.grey,
//                                  fontWeight: FontWeight.w600,
//                                ),
//                              ),
//                            ],
//                          ),
//                          Expanded(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                Container(
//                                  width: 60.0,
//                                  child: FlatButton(
//                                    padding: EdgeInsets.all(10.0),
//                                    onPressed: () => print('Go to product'),
//                                    color: Colors.deepOrange,
//                                    child: Icon(
//                                      Icons.arrow_forward,
//                                      size: 30.0,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//          SizedBox(height: 15.0),
//          ProductCarousel(
//            title: 'Festive Deals',
//            products: products,
//          ),
//          ProductCarousel(
//            title: 'Popular Books',
//            products: books,
//          ),
//        ],
//      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop_mac),
            title: Text("Products"),
            backgroundColor: Colors.orange,
          ),
        ],
        onTap: onTabTapped,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
