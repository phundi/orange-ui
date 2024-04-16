import 'dart:async';

import 'package:get/get.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenViewModel extends BaseViewModel {
  String? videoPath;
  late VideoPlayerController videoPlayerController;
  bool isExceptionError = false;
  bool isUIVisible = false;

  void init() {
    videoInit();
  }

  VideoPlayerScreenViewModel(this.videoPath);

  void videoInit() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('${ConstRes.aImageBaseUrl}$videoPath'),
    )..initialize().then((value) {
        videoPlayerController.play().then((value) {
          isUIVisible = true;
          notifyListeners();
        });
      }).onError((e, e1) {
        isExceptionError = true;
        notifyListeners();
      }).catchError((e) {
        isExceptionError = true;
        notifyListeners();
      });
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onPlayPauseTap() {
    isUIVisible = !isUIVisible;
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
