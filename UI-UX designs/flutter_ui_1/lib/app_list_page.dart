import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_1/widgets/app_bar.dart';
import 'package:flutter_ui_1/widgets/brand_selector.dart';
import 'package:flutter_ui_1/widgets/card_list.dart';
import 'package:flutter_ui_1/widgets/small_card.dart';
import 'package:flutter_ui_1/widgets/title_text.dart';

class BrandItem {
  final String name;
  final bool isActive;

  BrandItem({@required this.name, @required this.isActive});
}

class WatchListItem {
  final Key key;
  final Color color;
  final String imageUrl;
  bool shouldScale;

  WatchListItem({
    @required this.key,
    @required this.color,
    @required this.imageUrl,
    @required this.shouldScale,
  });
}

class AppListPage extends StatefulWidget {
  @override
  _AppListPageState createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  List<BrandItem> _brands;
  List<WatchListItem> _topListItems;
  List<WatchListItem> _bottomListItems;

  @override
  void initState() {
    super.initState();
    final String _watchImageUrl = "assets/images/apple1.png";

    _brands = [
      BrandItem(name: 'Apple', isActive: true),
      BrandItem(name: 'OnePlus', isActive: false),
      BrandItem(name: 'Samsung', isActive: false),
      BrandItem(name: 'Xiaomi', isActive: false),
    ];

    _topListItems = [
      WatchListItem(
          key: Key('one'),
          imageUrl: _watchImageUrl,
          color: Colors.redAccent[200],
          shouldScale: true,
      ),
      WatchListItem(
          key: Key('two'),
          imageUrl: _watchImageUrl,
          color: Colors.greenAccent[200],
          shouldScale: false,
      ),
      WatchListItem(
          key: Key('three'),
          imageUrl: _watchImageUrl,
          color: Colors.blueAccent[200],
          shouldScale: false,
      ),
    ];

    _bottomListItems = [
      WatchListItem(
        key: Key('b_one'),
        imageUrl: _watchImageUrl,
        color: Colors.lightBlueAccent[200],
        shouldScale: false,
      ),
      WatchListItem(
        key: Key('b_two'),
        imageUrl: _watchImageUrl,
        color: Colors.pinkAccent[200],
        shouldScale: false,
      ),
      WatchListItem(
        key: Key('b_three'),
        imageUrl: _watchImageUrl,
        color: Colors.indigoAccent[200],
        shouldScale: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyAppbar(),
                SizedBox(height: 10.0,),
                TitleText(title: 'Discover', subtitle: false,),
                SizedBox(height: 20.0,),
                BrandSelector(brands: _brands,),
                SizedBox(height: 20.0,),
                CardList(listItems: _topListItems,),
                TitleText(title: 'Discount Offer', subtitle: true,),
                SizedBox(height: 20.0,),
                Container(
                    height: 260,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          offset: Offset(-6.0, -6.0),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(6.0, 6.0),
                          blurRadius: 16.0,
                        ),
                      ],
                      color: Color(0xFFEFEEEE),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _bottomListItems.length,
                      itemBuilder: (BuildContext context, int index) =>
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child:SmallCard(watchListItem: _bottomListItems[index],)
                        ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
