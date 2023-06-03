import 'package:get/get.dart';
import 'package:orange_ui/screen/livestream_dashboard_screen/livestream_dashboard_screen.dart';
import 'package:orange_ui/screen/login_dashboard_screen/login_dashboard_screen.dart';
import 'package:orange_ui/screen/premium_screen/premium_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:stacked/stacked.dart';

class OptionalScreenViewModel extends BaseViewModel {
  void init() {}

  bool notificationEnable = true;
  bool showMeOnMap = true;
  bool goAnnonymous = true;

  void onBackBtnTap() {
    Get.back();
  }

  void onGoPremiumTap() {
    Get.to(() => const PremiumScreen());
  }

  void onLiveStreamTap() {
    Get.to(() => const LiveStreamDashBoard());
  }

  void onNotificationTap() {
    notificationEnable = !notificationEnable;
    notifyListeners();
  }

  void onSHowMeOnMapTap() {
    showMeOnMap = !showMeOnMap;
    notifyListeners();
  }

  void onGoAnnonymousTap() {
    goAnnonymous = !goAnnonymous;
    notifyListeners();
  }

  void onPrivacyPolicyTap() {}

  void onTermsOfUseTap() {}

  void onHelpNSupportTap() {}

  void onLogoutTap() {
    PrefService.setLoginText(false);
    Get.offAll(() => const LoginDashboardScreen());
  }

  void onDeleteAccountTap() {}
}
