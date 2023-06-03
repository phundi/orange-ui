import 'package:get/get.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen.dart';
import 'package:orange_ui/screen/premium_screen/premium_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class UserDetailScreenViewModel extends BaseViewModel {
  void init(bool? showInfo) {
    if (showInfo == true) {
      onMoreInfoTap();
    }
  }

  bool moreInfo = false;
  bool like = false;
  int selectedImgIndex = 3;
  bool save = false;
  List<String> imageList = [
    AssetRes.p1,
    AssetRes.p2,
    AssetRes.p3,
    AssetRes.profile6,
  ];
  List<String> interestList = [
    AppRes.musicCap,
    AppRes.travelCap,
    AppRes.yoga,
    AppRes.sports,
    AppRes.photography,
    AppRes.pets,
  ];

  void onImageSelect(int index) {
    selectedImgIndex = index;
    notifyListeners();
  }

  void onJoinBtnTap() {
    Get.to(() => const PremiumScreen());
  }

  void onLikeBtnTap() {
    like = !like;
    notifyListeners();
  }

  void onMoreInfoTap() {
    moreInfo = true;
    notifyListeners();
  }

  void onHideInfoTap() {
    moreInfo = false;
    notifyListeners();
  }

  void onBackTap() {
    Get.back();
  }

  void onMoreBtnTap() {}

  void onSaveTap() {
    save = !save;
    notifyListeners();
  }

  void onChatWithBtnTap() {
    Get.to(() => const ChatScreen());
  }

  void onShareProfileBtnTap() {}

  void onReportTap() {}
}
