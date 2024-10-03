//import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/common_ui.dart';

import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:stacked/stacked.dart';

class DashboardScreenViewModel extends BaseViewModel {
  int pageIndex = 0;
  RegistrationUserData? userData;

  Appdata? settingAppData;

  void init() {
   // initBranch();
    getProfileApiCall();
  }

  void getProfileApiCall() {
    ApiProvider().getProfile(userID: PrefService.userId).then((value) {
      userData = value?.data;
      notifyListeners();
    });
    PrefService.getSettingData().then((value) {
      settingAppData = value?.appdata;
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
      return CommonUI.snackBarWidget(S.current.userBlock);
    }
    pageIndex = index;
    notifyListeners();
  }
}
