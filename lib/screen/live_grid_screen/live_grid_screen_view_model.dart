import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/confirmation_dialog.dart';
import 'package:orange_ui/common/widgets/loader.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/chat_and_live_stream/live_stream.dart';
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

  void init() {
    db = FirebaseFirestore.instance;
    getProfileAPi();
    getBannerAd();
    initInterstitialAds();
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
    });
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  }

  void goLiveBtnClick() {
    registrationUser?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.dialog(
            ConfirmationDialog(
              onYesBtnClick: onGoLiveYesBtnTap,
              aspectRatio: 1 / 0.6,
              horizontalPadding: 60,
              onNoBtnClick: onBackBtnTap,
              subDescription: S.current.doYouReallyWantToLive,
              heading: S.current.areYouSure,
              clickText2: S.current.cancel,
              clickText1: S.current.continueText,
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
      return SnackBarWidget().snackBarWidget(S.current.userBlock);
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
            if (PrefService.liveWatchingPrice <= walletCoin! &&
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
                            child: Loader().lottieWidget(),
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
                    dialogDisc: AppRes.liveStreamDisc,
                    coinPrice: '${PrefService.liveWatchingPrice}'),
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
    await ApiProvider().minusCoinFromWallet(PrefService.liveWatchingPrice);
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
}
