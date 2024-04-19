import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:stacked/stacked.dart';

class DashboardScreenViewModel extends BaseViewModel {
  int pageIndex = 0;
  RegistrationUserData? userData;

  void init() {
    FlutterBranchSdk.initSession().listen(
      (data) {
        if (data.containsKey("+clicked_branch_link") &&
            data["+clicked_branch_link"] == true) {
          if (data.containsKey('user_id')) {
            Get.to(() => UserDetailScreen(userId: int.parse(data['user_id'])));
          }
        }
      },
      onError: (error) {
        PlatformException platformException = error as PlatformException;
        SnackBarWidget().snackBarWidget(
            'InitSession error: ${platformException.code} - ${platformException.message}');
      },
    );
    getProfileApiCall();
  }

  void getProfileApiCall() {
    ApiProvider().getProfile(userID: PrefService.userId).then((value) {
      userData = value?.data;
      notifyListeners();
    });
  }

  void onBottomBarTap(int index) {
    if (userData?.isBlock == 1 && index == 4) {
      pageIndex = index;
      notifyListeners();
      return;
    }
    if (userData?.isBlock == 1) {
      return SnackBarWidget().snackBarWidget(S.current.userBlock);
    }
    pageIndex = index;
    notifyListeners();
  }
}
