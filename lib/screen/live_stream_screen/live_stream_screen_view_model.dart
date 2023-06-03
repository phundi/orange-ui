import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LiveStreamScreenViewModel extends BaseViewModel {
  void init() {}

  TextEditingController aboutController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController link1Controller = TextEditingController();
  TextEditingController link2Controller = TextEditingController();

  void onVideoControllerChange(String? value) {
    if (videoController.text == '' || videoController.text.length == 1) {
      notifyListeners();
    }
  }

  void onSubmitBtnTap() {
    Get.back();
  }

  void onPlusBtnTap() {}

  void onRemoveBtnTap() {}

  void onBackBtnTap() {
    Get.back();
  }
}
