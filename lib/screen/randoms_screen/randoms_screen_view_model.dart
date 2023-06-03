import 'package:get/get.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/randoms_search_screen/randoms_search_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class RandomsScreenViewModel extends BaseViewModel {
  void init() {}

  List<String> genderList = [AppRes.boys, AppRes.both, AppRes.girls];
  String selectedGender = AppRes.both;
  String image = AssetRes.profile16;

  void onNotificationTap() {
    Get.to(() => const NotificationScreen());
  }

  void onSearchBtnTap() {
    Get.to(() => const SearchScreen());
  }

  void onGenderChange(String value) {
    selectedGender = value;
    notifyListeners();
  }

  void onStartMatchingTap() {
    Get.to(() => const RandomsSearchScreen());
  }
}
