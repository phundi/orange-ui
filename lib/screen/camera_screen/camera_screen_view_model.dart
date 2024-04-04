import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:orange_ui/main.dart';
import 'package:orange_ui/screen/camera_preview_screen/camera_preview_screen.dart';
import 'package:stacked/stacked.dart';

class CameraScreenViewModel extends BaseViewModel {
  late CameraController controller;

  void init() {
    initCamera();
  }

  void initCamera() {
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      notifyListeners();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  void captureImage() {
    controller.takePicture().then((value) {
      Get.to(() => CameraPreviewScreen(xFile: value));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onCameraFlip() {
    cameras[1];
  }
}
