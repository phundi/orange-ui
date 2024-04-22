import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/screen/camera_preview_screen/camera_preview_screen.dart';
import 'package:orange_ui/screen/camera_screen/widget/media_sheet.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class CameraScreenViewModel extends BaseViewModel {
  late CameraController cameraController;
  List<CameraDescription> cameras;
  bool isLoading = true;
  Timer? timer;
  var currentTime = ''.obs;
  ImagePicker imagePicker = ImagePicker();
  bool isFirstTimeLoadCamera = true;
  CameraScreenViewModel(this.cameras);

  void init() {
    initCamera(cameras[0]);
  }

  void initCamera(CameraDescription cameraDescription) async {
    isLoading = true;
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    cameraController.initialize().then((_) async {
      if (isFirstTimeLoadCamera) {
        await cameraController
            .lockCaptureOrientation(DeviceOrientation.portraitUp);
        await cameraController.prepareForVideoRecording();
      }
      isFirstTimeLoadCamera = false;
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
    if (cameraController.description.lensDirection ==
        CameraLensDirection.front) {
      final CameraDescription selectedCamera = cameras[0];
      initCamera(selectedCamera);
    } else {
      final CameraDescription selectedCamera = cameras[1];
      initCamera(selectedCamera);
    }
    notifyListeners();
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

  void setCurrentTimerClock() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      currentTime.value = timer.tick.toString();
    });
  }

  void onMediaTap() {
    Get.bottomSheet(MediaSheet(
      onTap: (type) {
        if (type == 1) {
          imagePicker
              .pickImage(
                  source: ImageSource.gallery,
                  maxHeight: maxHeight,
                  imageQuality: quality,
                  maxWidth: maxWidth)
              .then((value) {
            if (value != null) {
              Get.back();
              Get.to(() => CameraPreviewScreen(xFile: value, type: 0));
            }
          });
        } else {
          imagePicker.pickVideo(source: ImageSource.gallery).then((value) {
            if (value != null) {
              Get.back();
              Get.to(() => CameraPreviewScreen(xFile: value, type: 1));
            }
          });
        }
      },
    ));
  }

  @override
  void dispose() {
    timer?.cancel();
    cameraController.dispose();
    super.dispose();
  }
}
