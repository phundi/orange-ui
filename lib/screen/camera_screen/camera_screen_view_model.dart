import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/camera_preview_screen/camera_preview_screen.dart';
import 'package:stacked/stacked.dart';

class CameraScreenViewModel extends BaseViewModel {
  late CameraController cameraController;
  List<CameraDescription> cameras;
  bool isLoading = true;
  Timer? timer;
  var currentTime = ''.obs;
  CameraScreenViewModel(this.cameras);

  void init() {
    initCamera();
  }

  void initCamera() async {
    isLoading = true;
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraController.initialize().then((_) async {
      await cameraController
          .lockCaptureOrientation(DeviceOrientation.portraitUp);
      await cameraController.prepareForVideoRecording();
      isLoading = false;
      notifyListeners();
    });
  }

  void captureImage() {
    cameraController.takePicture().then((value) {
      Get.to(() => CameraPreviewScreen(xFile: value, type: 0));
    });
  }

  void onCameraFlip() {
    cameras[1];
  }

  void onCaptureVideoStart(LongPressStartDetails details) async {
    cameraController.startVideoRecording();
    setCurrentTimerClock();
  }

  void onCaptureVideoEnd(LongPressEndDetails details) {
    timer?.cancel();
    cameraController.stopVideoRecording().then((value) {
      Get.to(() => CameraPreviewScreen(xFile: value, type: 1))?.then((value) {
        currentTime = ''.obs;
        notifyListeners();
      });
    });
  }

  setCurrentTimerClock() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      currentTime.value = timer.tick.toString();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    cameraController.dispose();
    super.dispose();
  }
}
