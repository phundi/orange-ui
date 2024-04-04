import 'package:flutter/cupertino.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:stacked/stacked.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreenViewModel extends BaseViewModel {
  StoryController storyController = StoryController();
  List<StoryItem> storyItems = [
    StoryItem.text(title: 'Dhruv Kathiriya', backgroundColor: ColorRes.orange2, textStyle: const TextStyle(color: ColorRes.white, fontFamily: FontRes.bold, fontSize: 22)),
    StoryItem.pageImage(
      url: 'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
      controller: StoryController(),
    ),
  ];

  void init() {}
}
