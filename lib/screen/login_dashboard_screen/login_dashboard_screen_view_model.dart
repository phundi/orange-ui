import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/login_pwd_screen/login_pwd_screen.dart';
import 'package:orange_ui/screen/register_screen/register_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:stacked/stacked.dart';

class LoginDashboardScreenViewModel extends BaseViewModel {
  void init() {}

  TextEditingController emailController =
      TextEditingController(text: 'demo@gmail.com');
  FocusNode emailFocus = FocusNode();
  String emailError = "";

  void onContinueTap() {
    bool validation = isValid();
    notifyListeners();
    emailFocus.unfocus();
    if (validation) {
      Get.to(() => LoginPwdScreen(email: emailController.text));
    }
  }

  bool isValid() {
    if (emailController.text == "") {
      emailError = AppRes.enterEmail;
      return false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailController.clear();
      emailError = AppRes.validEmail;
      return false;
    } else {
      emailError = "";
      return true;
    }
  }

  void onGoogleTap() {}

  void onFacebookTap() {}

  void onAppleTap() {}

  void onSignUpTap() {
    Get.to(() => const RegisterScreen());
  }

  void onForgotPwdTap() {}
}
