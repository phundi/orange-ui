import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class LoginPwdScreenViewModel extends BaseViewModel {
  void init(String email) {
    this.email = email;
  }

  String? email;
  TextEditingController pwdController = TextEditingController();
  FocusNode pwdFocus = FocusNode();
  String pwdError = "";
  bool showPwd = false;

  void onViewBtnTap() {
    showPwd = !showPwd;
    notifyListeners();
  }

  Future<void> onContinueTap() async {
    bool validation = inValid();
    notifyListeners();
    pwdFocus.unfocus();
    if (validation) {
      await PrefService.setLoginText(true);
      Get.offAll(() => const StartingProfileScreen());
    }
  }

  bool inValid() {
    if (pwdController.text == "") {
      pwdError = AppRes.enterPassword;
      return false;
    } else {
      return true;
    }
  }

  void onForgotPwdTap() {}
}
