import 'package:get/get.dart';
import 'package:orange_ui/screen/video_calling_screen/video_calling_screen.dart';
import 'package:stacked/stacked.dart';

class IncomingCallScreenViewModel extends BaseViewModel {
  void init() {}

  void onCallReceive() {
    Get.off(() => const VideoCallingScreen());
  }

  void onCallCut() {
    Get.back();
  }
}
