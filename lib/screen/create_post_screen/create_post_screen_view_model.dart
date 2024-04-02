import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class CreatePostScreenViewModel extends BaseViewModel {
  int pageType = 0;

  PageController pageController = PageController();
  List<String> interests = [
    'Athletics',
    'Photography',
    'Dance',
    'Singing',
    'Travel',
    'Gym',
    'Swimming',
    'Music',
    'Walking',
    'Pets',
    'Cooking',
    'Fitness',
    'Sports',
    'Fashion',
    'Disney',
    'Instagram',
  ];
  List<String> selectedInterests = [
    'Dance',
    'Music',
    'Fitness',
  ];

  void init() {
    pageType = 0;
  }

  onNextClick(int type) {
    if (type == 0) {
      pageType = 1;
    } else {
      Get.back();
    }
    notifyListeners();
  }

  onInterestTap(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }
}
