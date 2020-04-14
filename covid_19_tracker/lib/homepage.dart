import 'dart:convert';
import 'package:covid_19_tracker/datasource.dart';
import 'package:covid_19_tracker/panels/worldwidepanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all') ;
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19 Tracker',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.white, fontSize: 26.0,
              ),
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              height: 100,
              color: Colors.black87,
              child: Text(
                DataSource.quote,
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(color:Colors.lightGreenAccent,fontSize: 17.0 )
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'WorldWide',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: primaryBlack,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [BoxShadow(
                        offset: Offset(5.0,5.0),
                        color: Colors.grey,
                        blurRadius: 2.0,
                      )]
                    ),
                    child: Text(
                      'Regional',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle( fontSize: 18.0, color: Colors.white),
                      )
                    ),
                  ),
                ],
              ),
            ),
            worldData==null ? Center(child: CircularProgressIndicator()) : WorldWidePanel(worldData: worldData,),
          ],
        ),
      ),
    );
  }
}
