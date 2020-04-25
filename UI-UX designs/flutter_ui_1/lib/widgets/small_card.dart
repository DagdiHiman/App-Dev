import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_1/app_list_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallCard extends StatelessWidget {

  final WatchListItem watchListItem;

  const SmallCard({Key key,@required this.watchListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: watchListItem.color,
          borderRadius: BorderRadius.circular(200.0),
          boxShadow: [BoxShadow(
            color: watchListItem.color,
            spreadRadius: 2.0,
            blurRadius: 10.0,
          )]
      ),
      child: Column(
        children: [
          Flexible(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCardImage(),
                buildCardTitle(),
              ],
            ),
          )
        ],
      ),

    );
  }

  Padding buildCardTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 2.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Apple Watch 3',
            style: GoogleFonts.droidSans(
                textStyle: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.7))
            ),
          ),
          SizedBox(height: 2.0,),
          Text('\$ 149',
            style: GoogleFonts.droidSans(
                textStyle: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.7))
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildCardImage() {
    return Positioned(
      bottom: 70,
      right: -40,
      child: Image.asset(
        'assets/images/apple2.png',
        height: 170,
        width: 170,
      ),
    );
  }

}
