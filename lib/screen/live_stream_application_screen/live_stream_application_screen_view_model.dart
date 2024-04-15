import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/live_stream_application_screen/widgets/video_upload_dialog.dart';
import 'package:orange_ui/screen/video_preview_screen/video_preview_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class LiveStreamApplicationScreenViewModel extends BaseViewModel {
  void init() {}

  TextEditingController aboutController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController videoController = TextEditingController();

  FocusNode aboutFocus = FocusNode();
  FocusNode languageFocus = FocusNode();
  FocusNode socialLinksFocus = FocusNode();

  List<TextEditingController> socialProfileController = <TextEditingController>[];
  List<String> socialLinks = [];
  XFile? _pickedFile;
  ImagePicker picker = ImagePicker();
  File? videoFile;
  String? videoImageFile;
  bool isVideoAttach = true;
  int fieldCount = 1;
  bool isAbout = false;
  bool isLanguages = false;
  bool isIntroVideo = false;
  bool isSocialLink = false;

  void onVideoControllerChange(String? value) {
    if (videoController.text == '' || videoController.text.length == 1) {
      notifyListeners();
    }
  }

  void onPlusBtnTap(TextEditingController controller) {
    socialLinks.add(controller.text);
    notifyListeners();
  }

  void onRemoveBtnTap(TextEditingController controller) {
    socialLinks.remove(controller.text);
    notifyListeners();
  }

  void onSubmitBtnTap() {
    if (!isValid()) return;
    Loader().lottieLoader();
    ApiProvider()
        .applyForLive(videoFile, aboutController.text, languageController.text, socialLinks.join(','))
        .then((value) {
      SnackBarWidget().snackBarWidget(value.message!);
      Get.back();
      Get.back();
    });
  }

  bool isValid() {
    int i = 0;
    isAbout = false;
    isLanguages = false;
    isSocialLink = false;
    isIntroVideo = false;
    languageFocus.unfocus();
    aboutFocus.unfocus();
    socialLinksFocus.unfocus();
    notifyListeners();
    if (aboutController.text == '') {
      isAbout = true;
      i++;
      return false;
    } else if (languageController.text == '') {
      isLanguages = true;
      i++;
      return false;
    } else if (videoImageFile == null || videoImageFile!.isEmpty) {
      isIntroVideo = true;
      i++;
      return false;
    } else if (socialLinks.isEmpty) {
      SnackBarWidget().snackBarWidget(S.current.pleaseAddSocialLinks);
      socialProfileController.clear();
      isSocialLink = true;
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onVideoPlayBtnTap() {
    if (videoFile == null || videoFile!.path.isEmpty) return;
    Loader().lottieLoader();
    ApiProvider().getStoreFileGivePath(image: videoFile).then((value) {
      Get.back();
      Get.to(() => const VideoPreviewScreen(), arguments: value.path);
    });
  }

  void onVideoChangeBtnTap() {
    imagePicker();
  }

  void onAttachBtnTap() {
    imagePicker();
  }

  void imagePicker() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      late final Map<Permission, PermissionStatus> statusess;

      if (androidInfo.version.sdkInt <= 32) {
        statusess = await [
          Permission.storage,
        ].request();
      } else {
        statusess = await [
          Permission.photos,
        ].request();
      }

      var allAccepted = true;
      statusess.forEach((permission, status) {
        if (status != PermissionStatus.granted) {
          allAccepted = false;
        }
      });
      if (!allAccepted) {
        openAppSettings();
        return;
      }
    }
    _pickedFile = await picker
        .pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    )
        .onError((PlatformException error, stackTrace) {
      SnackBarWidget().snackBarWidget(error.message ?? '');
      return null;
    });
    if (_pickedFile == null || _pickedFile!.path.isEmpty) return;
    final file = File(_pickedFile?.path ?? '');
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb <= 50) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return Center(child: Loader().lottieWidget());
          },
          barrierDismissible: false);

      await VideoThumbnail.thumbnailFile(
        video: _pickedFile!.path,
      ).then((value) {
        videoFile = File(_pickedFile?.path ?? '');
        videoImageFile = value;
        isVideoAttach = false;
        Get.back();
        notifyListeners();
      });
    } else {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return VideoUploadDialog(
            cancelBtnTap: onBackBtnTap,
            selectAnother: () {
              Get.back();
              imagePicker();
            },
          );
        },
      );
    }
  }
}
