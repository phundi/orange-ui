import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/map_screen/map_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/premium_screen/premium_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class ExploreScreenViewModel extends BaseViewModel {
  void init() {
    pageController = PageController(initialPage: 0, viewportFraction: 1.01)
      ..addListener(() {
        changeMainImage();
      });
    getDataFromPrefs();
  }

  int imageIndex = 0;
  List<String> imageList = [
    AssetRes.p1,
    AssetRes.p2,
    AssetRes.p3,
  ];
  late PageController pageController;
  String userName = '';
  int age = 0;
  String address = '';
  String bioText = '';
  int currentPageIndex = 0;

  Future<void> getDataFromPrefs() async {
    userName = (await PrefService.getFullName()) ?? '';
    age = (await PrefService.getAge()) ?? 0;
    address = (await PrefService.getAddress()) ?? '';
    bioText = (await PrefService.getBioText()) ?? '';
    notifyListeners();
  }

  void changeMainImage() {
    //imageIndex = index;
    if (pageController.page!.round() != currentPageIndex) {
      currentPageIndex = pageController.page!.round();
      notifyListeners();
    }
  }

  void onNotificationTap() {
    Get.to(() => const NotificationScreen());
  }

  void onTitleTap() {
    Get.to(() => const MapScreen());
  }

  void onSearchTap() {
    Get.to(() => const SearchScreen());
  }

  void onImageTap() {
    Get.to(() => const UserDetailScreen());
  }

  void onLiveBtnTap() {
    Get.to(() => const PremiumScreen());
  }

  void onPlayButtonTap() {
    Get.to(() => const PremiumScreen());
  }

  void onNextButtonTap() {}

  void onEyeButtonTap() {
    Get.to(() => const UserDetailScreen(showInfo: true));
  }
}
