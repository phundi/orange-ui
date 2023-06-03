import 'package:get/get.dart';
import 'package:orange_ui/screen/randoms_video_call_screen/randoms_video_call_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class RandomsSearchScreenViewModel extends BaseViewModel {
  void init() {}

  String image = AssetRes.profile16;

  void onSearchingTextTap() {
    Get.to(() => const RandomsVideoCallScreen());
  }

  void onCancelTap() {
    Get.back();
  }

  void onBackBtnTap() {
    Get.back();
  }
}
