import 'package:get/get.dart';
import 'package:orange_ui/screen/dashboard/dashboard.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class SelectHobbiesScreenViewModel extends BaseViewModel {
  void init() {}

  List<String> hobbiesList = [
    AppRes.athletics,
    AppRes.dance,
    AppRes.photography,
    AppRes.singingCap,
    AppRes.gym,
    AppRes.travelCap,
    AppRes.swimming,
    AppRes.musicCap,
    AppRes.walkingCap,
    AppRes.pets,
    AppRes.cooking,
    AppRes.fitnessCap,
    AppRes.sports,
    AppRes.fashion,
  ];

  List<String> selectedList = [];

  void onClipTap(String value) {
    bool selected = selectedList.contains(value);

    if (selected) {
      selectedList.remove(value);
    } else {
      selectedList.add(value);
    }
    notifyListeners();
  }

  void onNextTap() {
    Get.offAll(() => const Dashboard());
  }

  void onSkipTap() {
    Get.offAll(() => const Dashboard());
  }
}
