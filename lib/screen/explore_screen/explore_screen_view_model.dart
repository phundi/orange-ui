import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/bottom_diamond_shop/bottom_diamond_shop.dart';
import 'package:orange_ui/screen/map_screen/map_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/pref_res.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/reverse_swipe_dialog.dart';

class ExploreScreenViewModel extends BaseViewModel {
  int imageIndex = 0;
  bool isLoading = false;
  SwiperController userController = SwiperController();
  List<RegistrationUserData>? userData;
  int currentUserIndex = 0;
  int? walletCoin = 0;
  RegistrationUserData? users;
  bool isSelected = false;
  InterstitialAd? interstitialAd;

  void init() {
    exploreScreenApiCall();
    prefSetting();
  }

  void prefSetting() {
    PrefService.getSettingData().then((value) {
      PrefService.settingData = value;
      notifyListeners();
    });
    initInterstitialAds();
  }

  Future<void> exploreScreenApiCall() async {
    isLoading = true;
    ApiProvider().getExplorePageProfileList().then((value) async {
      userData = value.data;
      isLoading = false;
      getProfileAPi();
      notifyListeners();
    });
  }

  Future<void> getProfileAPi() async {
    ApiProvider().getProfile(userID: PrefService.userId).then((value) async {
      users = value?.data;
      walletCoin = value?.data?.wallet;
      isSelected =
          await PrefService.getDialog(PrefConst.isDialogDialog) ?? false;
      await PrefService.saveUser(value?.data);
    });
  }

  bool isSocialBtnVisible(String? socialLink) {
    if (socialLink != null) {
      return socialLink.contains(AppRes.isHttp) ||
          socialLink.contains(AppRes.isHttps);
    } else {
      return false;
    }
  }

  Future<void> minusCoinApi() async {
    await ApiProvider().minusCoinFromWallet(PrefService.reverseSwipePrice);
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
    )) throw '${S.current.couldNotLaunch} ';
  }

  void onInstagramTap() {
    _launchUrl(userData?[currentUserIndex].instagram ?? '');
  }

  void onFBTap() {
    _launchUrl(userData?[currentUserIndex].facebook ?? '');
  }

  void onYoutubeTap() {
    _launchUrl(userData?[currentUserIndex].youtube ?? '');
  }

  void onPlayButtonTap() async {
    if (users == null) {
      return;
    }
    if (users?.isBlock == 1) {
      return SnackBarWidget().snackBarWidget(S.current.userBlock);
    } else {
      if (users?.isFake != 1) {
        if (PrefService.reverseSwipePrice <= walletCoin! && walletCoin != 0) {
          !isSelected
              ? Get.dialog(
                  ReverseSwipeDialog(
                    isCheckBoxVisible: true,
                    walletCoin: walletCoin,
                    title1: S.current.reverse,
                    title2: S.current.swipe,
                    dialogDisc: AppRes.reverseSwipeDisc,
                    coinPrice: '${PrefService.reverseSwipePrice}',
                    onCancelTap: () {
                      onBackBtnTap();
                    },
                    onContinueTap: (isSelected) {
                      PrefService.setDialog(
                          PrefConst.isDialogDialog, isSelected);
                      minusCoinApi().then(
                        (value) {
                          onBackBtnTap();
                          userController.previous();
                        },
                      );
                    },
                  ),
                ).then(
                  (value) {
                    getProfileAPi();
                  },
                )
              : onPreviousBtnTap();
        } else {
          Get.dialog(
            EmptyWalletDialog(
              onCancelTap: onBackBtnTap,
              onContinueTap: () {
                Get.back();
                Get.bottomSheet(const BottomDiamondShop());
              },
              walletCoin: walletCoin,
            ),
          );
        }
      } else {
        userController.previous();
      }
    }
  }

  void onPreviousBtnTap() {
    minusCoinApi().then((value) {
      getProfileAPi();
      userController.previous(animation: true);
    });
  }

  void onBackBtnTap() {
    Get.back();
  }

  int count = 0;

  void onNextButtonTap() {
    count++;
    if (count == 5) {
      if (interstitialAd != null) {
        interstitialAd?.show().then((value) {
          count = 0;
          userController.next(animation: true);
          initInterstitialAds();
        });
      }
    } else {
      users?.isBlock == 1
          ? SnackBarWidget().snackBarWidget(S.current.userBlock)
          : userController.next(animation: true);
    }
  }

  void initInterstitialAds() {
    CommonFun.interstitialAd((ad) {
      interstitialAd = ad;
    });
  }

  void onIndexChange(int index) {
    currentUserIndex = index;
    notifyListeners();
  }

  void onNotificationTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void onTitleTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const MapScreen());
  }

  void onSearchTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const SearchScreen());
  }

  void onImageTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const UserDetailScreen(),
            arguments: userData?[currentUserIndex]);
  }

  void onLiveBtnTap() {
    // Get.to(() => const PremiumScreen());
  }

  void onEyeButtonTap() {
    users?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const UserDetailScreen(showInfo: true),
            arguments: userData?[currentUserIndex]);
  }

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }
}
