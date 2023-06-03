import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class PremiumScreenViewModel extends BaseViewModel {
  void init() {}

  int descIndex = 0;
  List<String> descTitle = [
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
  ];
  List<String> descSubtitle = [
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
  ];
  PageController pageController = PageController(initialPage: 0);
  int selectedOffer = 1;

  void onBackBtnTap() {
    Get.back();
  }

  void onExclusivePageChange(int index) {
    notifyListeners();
  }

  void onOfferSelect(int index) {
    selectedOffer = index;
    notifyListeners();
  }

  void onContinueTap() {
    Get.back();
  }

  void onNoThanksTap() {
    Get.back();
  }
}
