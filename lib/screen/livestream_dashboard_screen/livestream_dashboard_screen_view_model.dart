import 'package:get/get.dart';
import 'package:orange_ui/screen/live_stream_history_screen/live_stream_history_screen.dart';
import 'package:orange_ui/screen/live_stream_screen/live_stream_screen.dart';
import 'package:orange_ui/screen/redeem_screen/redeem_screen.dart';
import 'package:orange_ui/screen/submit_redeem_screen/submit_redeem_screen.dart';
import 'package:stacked/stacked.dart';

class LiveStreamDashBoardViewModel extends BaseViewModel {
  void init() {}

  bool eligible = false;
  bool redeem = false;

  void onRedeemTap() {
    Get.to(() => const SubmitRedeemSceen());
  }

  void onEligibleTap() {
    eligible = !eligible;
    notifyListeners();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onHistoryBtnTap() {
    Get.to(() => const LiveStreamHistory());
  }

  void onRedeemBtnTap() {
    Get.to(() => const RedeemScreen());
  }

  void onApplyBtnTap() {
    Get.to(() => const LiveStreamScreen());
  }
}
