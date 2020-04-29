import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //used to control the media story
    final controller = StoryController();

    //Sample Story List
    List<StoryItem> storyItems = [
      StoryItem.text(title: "Hey", backgroundColor: Colors.blueGrey),
      StoryItem.pageImage(url: 'https://img.icons8.com/plasticine/2x/user.png', controller: controller),
      StoryItem.text(title: "My Name is Himan", backgroundColor: Colors.redAccent),

    ];

    return Material(
      child: StoryView(
        storyItems: storyItems,
        controller: controller,
        inline: false,
        repeat: true,
      ),
    );
  }

}