import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/confirmation_dialog.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/story_view/controller/story_controller.dart';
import 'package:orange_ui/story_view/widgets/story_view.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

class StoryViewScreenViewModel extends BaseViewModel {
  StoryController storyController = StoryController();
  List<List<StoryItem>> stories = [];
  List<RegistrationUserData> userStories = [];
  PageController pageController;
  int index = 0;

  StoryViewScreenViewModel(this.userStories, this.index, this.pageController) {
    for (var user in userStories) {
      List<StoryItem> userStories =
          user.story?.map((e) => e.toStoryItem(storyController)).toList() ?? [];
      stories.add(userStories);
      notifyListeners();
    }
  }

  void init() {}

  void onStoryShow(StoryItem value) {
    if (!value.viewedByUsersIds.contains('${PrefService.userId}')) {
      ApiProvider().callPost(
          completion: (response) {},
          url: Urls.aViewStory,
          param: {Urls.aUserId: PrefService.userId, Urls.aStoryId: value.id});
    }
  }

  void onPreviousUser() {
    if (index == 0) {
      return;
    }
    pageController.animateToPage(index - 1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void onNext() {
    if (index == (stories.length - 1)) {
      Get.back();
      return;
    }
    pageController.animateToPage(index + 1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void onPageChange(int value) {
    index = value;
    notifyListeners();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  void onStoryDelete(Story? story) {
    Get.dialog(
      ConfirmationDialog(
        onTap: () {
          Get.back();
          stories[index].removeWhere((element) {
            return element.story?.id == story?.id;
          });

          ApiProvider().callPost(
            completion: (response) {
              print(response);
            },
            url: Urls.aDeleteStory,
            param: {
              Urls.aMyUserId: PrefService.userId,
              Urls.aStoryId: story?.id
            },
          );
          onNext();
          notifyListeners();
        },
        description:
            'Do you want to delete this story?, You can not restore the story it will be permanently deleted.',
        heading: 'Delete this story?',
        padding: const EdgeInsets.symmetric(horizontal: 40),
      ),
    ).then((value) {
      storyController.play();
    });
  }
}
