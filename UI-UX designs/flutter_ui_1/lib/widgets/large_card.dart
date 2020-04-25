import 'package:flutter/material.dart';
import 'package:flutter_ui_1/app_list_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeCard extends StatelessWidget {

  final WatchListItem watchListItem;

  const LargeCard({Key key, this.watchListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 230,
      decoration: BoxDecoration(
          color: watchListItem.color,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(
            offset: Offset(5, 5),
            color: Colors.grey,
            blurRadius: 7.0,
          )
          ]
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          buildCardTitle(),
          buildCardImage(),
        ],
      ),
    );
  }

  Padding buildCardTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Apple Watch 5',
                style: GoogleFonts.droidSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0)
                ),
              ),
              IconButton(icon: Icon(Icons.favorite_border, size: 30.0,),
                onPressed: () {},)
            ],),
          SizedBox(height: 2.0,),
          Text('\$ 189',
            style: GoogleFonts.droidSans(
                textStyle: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black.withOpacity(0.7))
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildCardImage() {
    return Positioned(
      bottom: -120,
      right: -60,
      child: Image.asset(
        watchListItem.imageUrl,
        height: 500,
        width: 270,
      ),
    );
  }

}