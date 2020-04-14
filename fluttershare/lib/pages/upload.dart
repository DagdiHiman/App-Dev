import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {

  final User currentUser;

  Upload({ this.currentUser });

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> with
    AutomaticKeepAliveClientMixin<Upload> {

  File file;
  bool isUploading = false;
  String postId = Uuid().v4();
  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 675.0,
        maxWidth: 960.0,
    );
    setState(() {
      this.file = file;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,);
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext){
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Photo with Camera"),
              onPressed: handleTakePhoto,
            ),
            SimpleDialogOption(
              child: Text("Image from Gallery"),
              onPressed: handleChooseFromGallery,
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }

    );
  }

  Container buildSplashScreen(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal,
              Colors.purpleAccent,
            ]
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/images/upload.svg", height: 260.0,),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: RaisedButton(
                elevation: 12.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "Upload",
                  style: TextStyle(color: Colors.white, fontSize: 26.0),
                ),
                color: Colors.pinkAccent,
                onPressed: () => selectImage(context),
            ),
          ),
        ],
      ),
    );
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imagefile) async {
    StorageUploadTask uploadTask = storageRef.child("post_$postId.jpg")
        .putFile(imagefile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore({ String mediaUrl, String location, String description}) {
      postRef
        .document(widget.currentUser.id)
        .collection('userPosts')
        .document(postId)
        .setData({
          'postId' : postId,
          'ownerId' : widget.currentUser.id,
          'username' : widget.currentUser.username,
          'mediaUrl' : mediaUrl,
          'description' : description,
          'location' : location,
          'timestamp' : timestamp,
          'likes' : {},
          'pcount' : 0,
        });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    captionController.clear();
    locationController.clear();
    setState(() {
      file = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }

buildUploadForm() {

  //Shader Linear Gradient for Title Texts
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.pinkAccent, Colors.purple[300]],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 350.0, 70.0));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: clearImage,
        ),
        title: Text('Caption Post',
          style: TextStyle(
            foreground: Paint()..shader = linearGradient, fontSize: 26.0,
          ),
        ),
        actions: <Widget>[
         FlatButton(
           color: Colors.black,
            child: Text('POST',
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold,),
            ),
            onPressed: isUploading ? null : () => handleSubmit(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : SizedBox(),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file),
                    )
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black38,
                  )
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_circle, size: 40.0, color: Colors.black,) ,
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Where was this photo taken ..?',
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black38,
                    ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
                label: Text('Use Current Location',
                  style: TextStyle(
                    color: Colors.white, fontSize: 16.0,
                  ),
                ),
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              icon: Icon(Icons.my_location,size: 26.0,),
              color: Colors.pinkAccent,
              onPressed: getUserLocation,

            ),
          ),
        ],
      ),
    );
  }

  getUserLocation() async {
    Position position = await Geolocator().
        getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator().
        placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String adrs = '${placemark.locality}, ${placemark.country}';
    print(adrs);
    locationController.text = adrs;
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}
