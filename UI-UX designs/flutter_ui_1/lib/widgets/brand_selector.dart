import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_1/app_list_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandSelector extends StatelessWidget {
  final List<BrandItem> brands;

  BrandSelector({Key key, this.brands}) : super(key: key);

  final TextStyle activeTextStyle = TextStyle(fontWeight: FontWeight.bold);
  final TextStyle inactiveTextStyle =
              TextStyle(color: Colors.black.withOpacity(0.5),);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: brands.map(
            (BrandItem brand) => Row(children: [
              Text(brand.name,
                style: GoogleFonts.ubuntu(textStyle:
                          brand.isActive ? activeTextStyle : inactiveTextStyle
                        ),
              ),
              SizedBox(width: 25.0,),
            ]),
          ).toList(),
    );
  }
}
