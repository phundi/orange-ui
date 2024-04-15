import 'dart:async';
import 'dart:io';

import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreatePostScreenViewModel extends BaseViewModel {
  DetectableTextEditingController detectableTextFieldController = DetectableTextEditingController(
      detectedStyle: const TextStyle(fontSize: 18, color: ColorRes.orange2, fontFamily: FontRes.medium),
      regExp: detectionRegExp(atSign: false, url: false));
  int pageType = 0;
  final ImagePicker _picker = ImagePicker();

  PageController pageController = PageController();
  int imageIndex = 0;
  List<XFile> imagesFile = [];
  XFile? thumbnailFile;
  String? thumbnail;
  List<Interest> interests = [];
  List<int> selectedInterests = [];
  List<String> hashtagList = [];
  FocusNode detectableTextFieldFocusNode = FocusNode();
  int contentType = 2; // description content byDefault = 2

  VideoPlayerController? videoPlayerController;
  var currentDuration = Duration().obs;

  void init() {
    pageType = 0;
    _getPrefData();
  }

  void onNextClick(int type) {
    detectableTextFieldFocusNode.unfocus();
    if (type == 0) {
      pageType = 1;
    } else {
      addPostApiCalling();
    }
    notifyListeners();
  }

  void onInterestTap(int interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void onPhotoTap() {
    contentType = 0;
    detectableTextFieldFocusNode.unfocus();
    _picker.pickMultiImage(maxHeight: maxHeight, maxWidth: maxWidth, imageQuality: quality).then((value) {
      for (int i = 0; i < maxImagesForPost; i++) {
        imagesFile.add(value[i]);
        notifyListeners();
      }
    });
  }

  Timer? timer;
  void onVideoTap() {
    contentType = 1;
    detectableTextFieldFocusNode.unfocus();
    _picker.pickVideo(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        imagesFile.add(value);
        videoPlayerController = VideoPlayerController.file(File(value.path))
          ..initialize().then((value) {
            timer = Timer.periodic(const Duration(milliseconds: 10), (timer) async {
              if (videoPlayerController!.value.position <= videoPlayerController!.value.duration) {
                currentDuration.value = (await videoPlayerController?.position) ?? const Duration();
              }
            });
            notifyListeners();
          });
        thumbnail = await VideoThumbnail.thumbnailFile(video: value.path);
        notifyListeners();
      }
    });
  }

  void _getPrefData() {
    PrefService.getInterest().then((value) {
      if (value?.data != null || value!.data!.isNotEmpty) {
        for (var element in (value?.data ?? [])) {
          interests.add(element);
        }
      }
      notifyListeners();
    });
  }

  void onImageDelete() {
    detectableTextFieldFocusNode.unfocus();
    if (imagesFile.length > 1) {
      imagesFile.removeAt(imageIndex);
    } else {
      imagesFile.removeAt(0);
    }
    notifyListeners();
  }

  void onPageChanged(int value) {
    imageIndex = value;
  }

  void onChangeDetectableTextField(String value) {
    hashtagList = TextPatternDetector.extractDetections(value, hashTagRegExp);
    notifyListeners();
  }

  void onBackTap() {
    if (pageType == 0) {
      Get.back();
    } else {
      pageType = 0;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    detectableTextFieldController.dispose();
    pageController.dispose();
    detectableTextFieldFocusNode.dispose();
    timer?.cancel();
    super.dispose();
  }

  void addPostApiCalling() {
    List<String> removeHasTag = [];
    for (var element in hashtagList) {
      removeHasTag.add(element.replaceAll('#', ''));
    }
    Map<String, List<XFile?>>? filesMap = {};

    if (imagesFile.isNotEmpty) {
      if (contentType == 1) {
        filesMap[Urls.aThumbnail] = [XFile(thumbnail!)];
      }
      filesMap[Urls.aContent] = imagesFile;
    }
    Loader().lottieLoader();
    ApiProvider().multiPartCallApi(
        url: Urls.aAddPost,
        completion: (response) {
          Get.back();
          Get.back();
        },
        param: {
          Urls.aUserId: PrefService.userId,
          Urls.aDescription: detectableTextFieldController.text.trim(),
          Urls.aHashtags: removeHasTag.join(','),
          Urls.aInterestIds: selectedInterests.join(','),
          Urls.aContentType: imagesFile.isEmpty ? 2 : contentType
        },
        filesMap: filesMap);
  }

  void onChangeSlider(double value) {
    videoPlayerController?.seekTo(
      Duration(
        microseconds: value.toInt(),
      ),
    );
    notifyListeners();
  }
}
