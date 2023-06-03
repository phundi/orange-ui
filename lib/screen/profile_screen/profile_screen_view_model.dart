import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/options_screen/options_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class ProfileScreenViewModel extends BaseViewModel {
  void init() {
    pageController = PageController(initialPage: 0, viewportFraction: 1.01)
      ..addListener(() {
        onMainImageChange();
      });
    getDataFromPrefs();
  }

  int imageIndex = 0;
  List<String> imageList = [
    AssetRes.p1,
    AssetRes.p2,
    AssetRes.p3,
    AssetRes.profile6,
  ];
  String userName = '';
  int age = 0;
  String address = '';
  String bioText = '';
  int currentImageIndex = 0;
  late PageController pageController;

  Future<void> getDataFromPrefs() async {
    userName = (await PrefService.getFullName()) ?? "Nataliya Nora";
    age = (await PrefService.getAge()) ?? 24;
    address = (await PrefService.getAddress()) ?? AppRes.newYorkUsa;
    bioText = (await PrefService.getBioText()) ?? AppRes.profileBioText;
    notifyListeners();
  }

  void onEditProfileTap() {
    Get.to(() => const EditProfileScreen())!.then((value) {
      getDataFromPrefs();
    });
  }

  void onSearchBtnTap() {
    Get.to(() => const SearchScreen());
  }

  void onMainImageChange() {
    if (pageController.page!.round() != currentImageIndex) {
      currentImageIndex = pageController.page!.round();
      notifyListeners();
    }
  }

  void onNotificationTap() {
    Get.to(() => const NotificationScreen());
  }

  void onImageTap() {
    Get.to(() => const UserDetailScreen());
  }

  void onMoreBtnTap() {
    Get.to(() => const OptionScreen());
  }
}
