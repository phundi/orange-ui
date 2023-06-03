import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class RegisterScreenViewModel extends BaseViewModel {
  void init() {}

  TextEditingController fullNameController =
      TextEditingController(text: "Jesika Deo");
  TextEditingController pwdController = TextEditingController(text: "123456");
  TextEditingController confirmPwdController =
      TextEditingController(text: "123456");

  FocusNode fullNameFocus = FocusNode();
  FocusNode pwdFocus = FocusNode();
  FocusNode confirmPwdFocus = FocusNode();

  String fullNameError = '';
  String pwdError = '';
  String confirmPwdError = '';

  bool showPwd = false;

  void onViewTap() {
    showPwd = !showPwd;
    notifyListeners();
  }

  Future<void> onContinueTap() async {
    bool validation = isValid();
    notifyListeners();
    if (validation) {
      await PrefService.setFullName(fullNameController.text);
      Get.offAll(() => const StartingProfileScreen());
    }
  }

  bool isValid() {
    int count = 0;
    if (fullNameController.text == '') {
      count++;
      fullNameError = AppRes.enterFullName;
    }
    if (pwdController.text == '') {
      count++;
      pwdError = AppRes.enterPassword;
    }
    if (confirmPwdController.text == '') {
      count++;
      confirmPwdError = AppRes.enterConfirmPassword;
    } else {
      if (confirmPwdController.text != pwdController.text) {
        count++;
        confirmPwdController.clear();
        confirmPwdError = AppRes.passwordMismatch;
      }
    }

    return count == 0 ? true : false;
  }
}
