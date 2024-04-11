import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

class CreatePostScreenViewModel extends BaseViewModel {
  DetectableTextEditingController detectableTextFieldController = DetectableTextEditingController(
      detectedStyle: const TextStyle(fontSize: 18, color: ColorRes.orange2, fontFamily: FontRes.medium),
      regExp: detectionRegExp(atSign: false, url: false));
  int pageType = 0;
  final ImagePicker _picker = ImagePicker();

  PageController pageController = PageController();
  int imageIndex = 0;
  List<XFile> imagesFile = [];
  List<Interest> interests = [];
  List<int> selectedInterests = [];
  List<String> hashtagList = [];
  FocusNode detectableTextFieldFocusNode = FocusNode();

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
    detectableTextFieldFocusNode.unfocus();
    _picker.pickMultiImage(maxHeight: maxHeight, maxWidth: maxWidth, imageQuality: quality).then((value) {
      for (int i = 0; i < maxImagesForPost; i++) {
        imagesFile.add(value[i]);
        notifyListeners();
      }
    });
  }

  void onVideoTap() {
    detectableTextFieldFocusNode.unfocus();
    _picker.pickVideo(source: ImageSource.gallery);
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
    super.dispose();
  }

  void addPostApiCalling() {
    // String removeHashTag
    for (var element in hashtagList) {
      element.replaceAll('#', '');
    }
    // ApiProvider().multiPartCallApi(
    //     url: Urls.aAddPost,
    //     completion: (response) {
    //       print(response);
    //     },
    //     param: {
    //       Urls.aUserId: PrefService.userId,
    //       Urls.aDescription: detectableTextFieldController.text.trim(),
    //       Urls.aHashtags : hashtagList.
    //     });
  }
}
