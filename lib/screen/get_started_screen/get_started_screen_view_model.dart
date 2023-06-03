import 'package:get/get.dart';
import 'package:orange_ui/screen/dashboard/dashboard.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:stacked/stacked.dart';

class GetStartedScreenViewModel extends BaseViewModel {
  void init() {}

  int screenIndex = 0;

  Future<bool> onBack() async {
    if (screenIndex != 0) {
      screenIndex--;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  Future<void> screen1NextTap() async {
    bool isLogin = (await PrefService.getLoginText()) ?? false;

    if (isLogin) {
      Get.off(() => const Dashboard());
    } else {
      screenIndex = 1;
    }
    notifyListeners();
  }

  void onSkipTap() {
    Get.off(() => const LoginDashboardScreen());
  }

  void screen2NextTap() {
    screenIndex = 2;
    notifyListeners();
  }

  void screen3NextTap() {
    screenIndex = 3;
    notifyListeners();
  }

  void screen4NextTap() {
    Get.off(() => const LoginDashboardScreen());
  }
}
