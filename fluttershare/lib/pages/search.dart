import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}



class _SearchState extends State<Search> {

  Future<QuerySnapshot> searchResultsFuture;
  TextEditingController searchController = TextEditingController();

  handleSearch(String query) {
    Future<QuerySnapshot> users = userRef
        .where('username', isGreaterThanOrEqualTo: query)
        .getDocuments();

    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.black,
      title: TextFormField(
        controller: searchController,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search a User...',
            hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
              size: 28.0,
            ),
            suffixIcon: IconButton(
              icon : Icon(Icons.clear),
              onPressed: clearSearch,
              iconSize: 28.0,
              //color: Colors.white,
            ),
          ),
        onFieldSubmitted: handleSearch,
        ),
    );
  }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      //color: Colors.pink[50],
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.pinkAccent[100],
            Colors.deepPurpleAccent[100],
          ],
        ),
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset('assets/images/search.svg',
              height: orientation == Orientation.portrait ? 350.0 : 250.0,
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults(){
    return FutureBuilder(
      future: searchResultsFuture,
      // ignore: missing_return
      builder: (context, snapshot) {
        if( !snapshot.hasData){
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc){
          User user = User.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: buildSearchField(),
        body: searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {

  final User user;
  UserResult( this.user );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent[100],
      child: Column(children: <Widget>[
        GestureDetector(
          onTap: () => showProfile(context, profileId: user.id),
          child:  ListTile(
            leading: CircleAvatar(
              backgroundColor : Colors.lightBlue,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            title: Text(user.displayName, style: TextStyle(fontSize: 19.0,color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(user.username,style: TextStyle(fontSize: 17.0,color: Colors.white),),
          ),
        ),
        Divider(
          height: 20.0,
          color: Colors.white,
        )
      ],),

    );
  }
}

showProfile(BuildContext context, {String profileId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Profile(
        profileId: profileId,
      ),
    ),
  );
}
