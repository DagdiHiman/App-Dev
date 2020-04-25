import 'package:flutter/material.dart';
import 'package:flutter_ui_1/app_list_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'large_card.dart';

class CardList extends StatefulWidget {

  final List<WatchListItem> listItems;

  const CardList({Key key,@required this.listItems}) : super(key: key);
  
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return               Container(
      height: 340,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 30.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.listItems.length,
        itemBuilder: (BuildContext context, int index) =>
            VisibilityDetector(
              key: widget.listItems[index].key,
              onVisibilityChanged: (VisibilityInfo info) {
                var visiblePercentage = info.visibleFraction * 100;
                debugPrint(
                    'Widget ${info.key} is $visiblePercentage% visible');
                if (info.visibleBounds.width >= 180) {
                  //Should scale a card
                  setState(() {
                    widget.listItems[index].shouldScale = true;
                  });
                } else {
                  setState(() {
                    widget.listItems[index].shouldScale = false;
                  });
                }
              },
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    margin: const EdgeInsets.only(right: 30.0),
                    transform: widget.listItems[index].shouldScale ?
                    (Matrix4.identity()..scale(1.10,1.10)) :
                    (Matrix4.identity()..scale(0.95,0.95)..translate(0.0, 20.0)),
                    child: LargeCard(
                      watchListItem: widget.listItems[index],
                    ),
                  )),
            ),
      ),
    );
  }
}
