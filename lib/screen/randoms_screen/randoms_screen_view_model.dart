import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/live_grid_screen/live_grid_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/randoms_search_screen/randoms_search_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/firebase_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:stacked/stacked.dart';

class RandomsScreenViewModel extends BaseViewModel {
  RegistrationUserData? data;
  List<String> genderList = [S.current.boys, S.current.both, S.current.girls];
  String selectedGender = S.current.both;
  bool isLoading = false;
  BannerAd? bannerAd;

  void init() {
    getProfileApiCall();
    getBannerAd();
  }

  void getProfileApiCall() async {
    isLoading = true;
    PrefService.getUserData().then((value) {
      data = value;
      isLoading = false;
      notifyListeners();
    });
  }

  void onNotificationTap() {
    data?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void onSearchBtnTap() {
    data?.isBlock == 1 ? SnackBarWidget().snackBarWidget(S.current.userBlock) : Get.to(() => const SearchScreen());
  }

  void onLivesBtnClick() {
    Get.to(() => const LiveGridScreen());
  }

  void onGenderChange(String value) {
    data?.isBlock == 1 ? SnackBarWidget().snackBarWidget(S.current.userBlock) : selectedGender = value;
    notifyListeners();
  }

  void onStartMatchingTap() {
    data?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const RandomsSearchScreen(), arguments: [
            {Urls.aGender: selectedGender, FirebaseRes.image: data?.images?[0].image ?? ''}
          ]);
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  }
}
