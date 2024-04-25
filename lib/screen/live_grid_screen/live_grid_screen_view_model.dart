import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/common_fun.dart';
import 'package:orange_ui/common/common_ui.dart';
import 'package:orange_ui/common/confirmation_dialog.dart';

import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/chat_and_live_stream/live_stream.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/bottom_diamond_shop/bottom_diamond_shop.dart';
import 'package:orange_ui/screen/explore_screen/widgets/reverse_swipe_dialog.dart';
import 'package:orange_ui/screen/live_grid_screen/widgets/live_stream_end_sheet.dart';
import 'package:orange_ui/screen/person_streaming_screen/person_streaming_screen.dart';
import 'package:orange_ui/screen/random_streming_screen/random_streaming_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/firebase_res.dart';
import 'package:orange_ui/utils/urls.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class LiveGridScreenViewModel extends BaseViewModel {
  RegistrationUserData? registrationUser;
  String? identity;
  List<LiveStreamUser> userData = [];
  List<String?> userEmail = [];
  bool isLoading = false;
  late FirebaseFirestore db;
  late CollectionReference collection;
  StreamSubscription<QuerySnapshot<LiveStreamUser>>? subscription;
  int? walletCoin;
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  Appdata? settingAppData;

  void init() {
    db = FirebaseFirestore.instance;
    getProfileAPi();
    getBannerAd();
    initInterstitialAds();
    getSettingData();
  }

  void onBackBtnTap() {
    if (interstitialAd == null) {
      Get.back();
    } else {
      interstitialAd?.show().whenComplete(() {
        Get.back();
      });
    }
  }

  void initInterstitialAds() {
    CommonFun.interstitialAd((ad) {
      interstitialAd = ad;
    },
        adMobIntId: Platform.isIOS
            ? settingAppData?.admobIntIos
            : settingAppData?.admobInt);
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    },
        bannerId: Platform.isIOS
            ? settingAppData?.admobBannerIos
            : settingAppData?.admobBanner);
  }

  void goLiveBtnClick() {
    registrationUser?.isBlock == 1
        ? CommonUI.snackBarWidget(S.current.userBlock)
        : Get.dialog(
            ConfirmationDialog(
              onTap: onGoLiveYesBtnTap,
              description: S.current.doYouReallyWantToLive,
              dialogSize: 2,
              textButton: S.current.goLive,
              textImage: '',
              padding: const EdgeInsets.symmetric(horizontal: 40),
            ),
          );
  }

  Future<void> onGoLiveYesBtnTap() async {
    Get.back();
    await [Permission.camera, Permission.microphone].request().then((value) {
      if ((value[Permission.camera] == PermissionStatus.granted &&
              value[Permission.microphone] == PermissionStatus.granted) ||
          Platform.isIOS) {
        Get.to(() => const RandomStreamingScreen(), arguments: {
          Urls.aChannelId: registrationUser?.identity,
          Urls.aIsBroadcasting: true,
        })?.then((value) async {
          notifyListeners();
        });
      } else {
        openAppSettings();
      }
    });
  }

  void getLiveUsers() {
    isLoading = true;
    collection = db.collection(FirebaseRes.liveHostList);
    subscription = collection
        .withConverter(
          fromFirestore: LiveStreamUser.fromFirestore,
          toFirestore: (LiveStreamUser value, options) {
            return value.toFirestore();
          },
        )
        .snapshots()
        .listen((element) {
      userData = [];
      for (int i = 0; i < element.docs.length; i++) {
        userData.add(element.docs[i].data());
      }
      isLoading = false;
      notifyListeners();
    });
  }

  void onLiveStreamProfileTap(LiveStreamUser? user) {
    if (registrationUser?.isBlock == 1) {
      return CommonUI.snackBarWidget(S.current.userBlock);
    } else {
      String authString = '${ConstRes.customerId}:${ConstRes.customerSecret}';
      String authToken = base64.encode(authString.codeUnits);
      ApiProvider()
          .agoraListStreamingCheck(
              user?.hostIdentity ?? '', authToken, ConstRes.agoraAppId)
          .then((value) {
        if (value.data?.channelExist == true ||
            value.data!.broadcasters!.isNotEmpty) {
          if (registrationUser?.isFake != 1) {
            if ((settingAppData?.liveWatchingPrice ?? 0) <= walletCoin! &&
                walletCoin != 0) {
              Get.dialog(
                ReverseSwipeDialog(
                    onCancelTap: onBackBtnTap,
                    onContinueTap: (isSelected) {
                      Get.back();
                      showDialog(
                        context: Get.context!,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child: CommonUI.lottieWidget(),
                          );
                        },
                      );
                      minusCoinApi().then((value) {
                        onImageTap(user);
                      });
                    },
                    isCheckBoxVisible: false,
                    walletCoin: walletCoin,
                    title1: S.current.liveCap,
                    title2: S.current.streamCap,
                    dialogDisc: AppRes.liveStreamDisc(
                        settingAppData?.liveWatchingPrice ?? 0),
                    coinPrice: '${settingAppData?.liveWatchingPrice ?? 0}'),
              );
            } else {
              Get.dialog(
                EmptyWalletDialog(
                  onCancelTap: onBackBtnTap,
                  onContinueTap: () {
                    Get.back();
                    Get.bottomSheet(
                      const BottomDiamondShop(),
                    );
                  },
                  walletCoin: walletCoin,
                ),
              );
            }
          } else {
            onImageTap(user);
          }
        } else {
          Get.bottomSheet(LiveStreamEndSheet(
            name: user?.fullName ?? '',
            onExitBtn: () async {
              Get.back();
              db
                  .collection(FirebaseRes.liveHostList)
                  .doc(user?.hostIdentity)
                  .delete();
              final batch = db.batch();
              var collection = db
                  .collection(FirebaseRes.liveHostList)
                  .doc(user?.hostIdentity)
                  .collection(FirebaseRes.comments);
              var snapshots = await collection.get();
              for (var doc in snapshots.docs) {
                batch.delete(doc.reference);
              }
              await batch.commit();
            },
          ));
        }
      });
    }
  }

  Future<void> getProfileAPi() async {
    ApiProvider().getProfile(userID: PrefService.userId).then((value) async {
      registrationUser = value?.data;
      walletCoin = value?.data?.wallet;
      notifyListeners();
    });
    getLiveUsers();
  }

  Future<void> minusCoinApi() async {
    await ApiProvider()
        .minusCoinFromWallet(settingAppData?.liveWatchingPrice ?? 0);
    getProfileAPi();
  }

  void onImageTap(LiveStreamUser? user) {
    userEmail.add(registrationUser?.identity);
    db.collection(FirebaseRes.liveHostList).doc(user?.hostIdentity).update({
      FirebaseRes.watchingCount: user!.watchingCount! + 1,
      FirebaseRes.joinedUser: FieldValue.arrayUnion(userEmail)
    }).then((value) {
      Get.back();
      Get.to(() => const PersonStreamingScreen(), arguments: {
        Urls.aChannelId: user.hostIdentity,
        Urls.aIsBroadcasting: false,
        Urls.aUserInfo: user
      });
    }).then((value) {
      getProfileAPi();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void getSettingData() {
    PrefService.getSettingData().then((value) {
      settingAppData = value?.appdata;
      notifyListeners();
    });
  }
}
