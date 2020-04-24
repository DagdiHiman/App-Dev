import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_1/widgets/app_bar.dart';
import 'package:flutter_ui_1/widgets/brand_selector.dart';
import 'package:flutter_ui_1/widgets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';


class BrandItem {
  final String name;
  final bool isActive;

  BrandItem({
    @required this.name,
    @required this.isActive
  });

}


class WatchListItem {
  final Color color;
  final String imageUrl;

  WatchListItem({
    @required this.color,
    @required this.imageUrl,
  });


}


class AppListPage extends StatelessWidget {

  final List<BrandItem> brands = [
    BrandItem(name: 'Apple', isActive: true),
    BrandItem(name: 'OnePlus', isActive: false),
    BrandItem(name: 'Samsung', isActive: false),
    BrandItem(name: 'Xiaomi', isActive: false),
  ];

  final String _watchImageUrl = "assets/images/watch.png";

  final List<WatchListItem> topListItems = [
    WatchListItem(imageUrl: _watchImageUrl),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyAppbar(),
              SizedBox(height: 10.0,),
              TitleText(title: 'Discover'),
              SizedBox(height: 20.0,),
              BrandSelector( brands: brands,),
              SizedBox(height: 20.0,),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 200,
                      height: 130,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Column(
                        children: [
                          Text('1'),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Container(
                      width: 200,
                      height: 130,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Column(
                        children: [
                          Text('2'),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Container(
                      width: 200,
                      height: 130,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Column(
                        children: [
                          Text('3'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
