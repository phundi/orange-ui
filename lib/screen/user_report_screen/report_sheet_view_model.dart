import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/webview_screen/webview_screen.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

class ReportSheetViewModel extends BaseViewModel {
  void init() {}

  String fullName = '';
  String city = '';
  String userImage = '';
  String age = '';

  TextEditingController explainController = TextEditingController();
  FocusNode explainMoreFocus = FocusNode();
  String explainMoreError = '';
  String reason = S.current.cyberbullying;
  bool isExplainError = false;
  List<String> reasonList = [
    S.current.cyberbullying,
    S.current.harassment,
    S.current.personalHarassment,
    S.current.inappropriateContent
  ];

  bool? isCheckBox = false;
  bool isShowDown = false;

  void onCheckBoxChange(bool? value) {
    isCheckBox = value;
    explainMoreFocus.unfocus();
    notifyListeners();
  }

  void onReasonTap() {
    isShowDown = !isShowDown;
    explainMoreFocus.unfocus();
    notifyListeners();
  }

  void onAllScreenTap() {
    isShowDown = false;
    notifyListeners();
  }

  void onTermAndConditionClick() {
    Get.to(() => WebViewScreen(
        appBarTitle: S.current.termsOfUse, url: Urls.aTermsOfUse));
  }

  bool isValid() {
    int i = 0;
    explainMoreFocus.unfocus();
    isExplainError = false;

    if (explainController.text == '') {
      isExplainError = true;
      explainMoreError = S.current.enterFullReason;
      i++;
      return false;
    }
    if (isCheckBox == false) {
      Get.rawSnackbar(
        message: S.current.pleaseCheckTerm,
        backgroundColor: ColorRes.black,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
      );
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }

  void onSubmitBtnTap(int userId) {
    bool validation = isValid();
    if (userId == -1) {
      SnackBarWidget.snackBar(message: 'User Not Found!!');
      return;
    }
    notifyListeners();
    if (validation) {
      ApiProvider().addReport(reason, explainController.text, userId).then(
        (value) {
          SnackBarWidget().snackBarWidget('Reported Successfully!!');
          Get.back();
        },
      );
    }
  }

  void onBackBtnClick() {
    Get.back();
  }

  void onReasonChange(String value) {
    reason = value;
    isShowDown = !isShowDown;
    notifyListeners();
  }
}
