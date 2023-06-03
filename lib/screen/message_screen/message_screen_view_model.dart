import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/api_provider/api_provider.dart';
import 'package:orange_ui/common/widgets/common_fun.dart';
import 'package:orange_ui/common/widgets/snack_bar_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/firebase_res.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/confirmation_dialog.dart';

class MessageScreenViewModel extends BaseViewModel {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Conversation?> userList = [];
  Conversation? conversation;
  bool isLoading = false;
  StreamSubscription<QuerySnapshot<Conversation>>? subscription;
  RegistrationUserData? userData;
  BannerAd? bannerAd;

  void init() {
    getChatUsers();
    getProfileApi();
    getBannerAd();
  }

  void onNotificationTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void getProfileApi() {
    ApiProvider().getProfile(userID: PrefService.userId).then((value) {
      userData = value?.data;
      notifyListeners();
    });
  }

  void onSearchTap() {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const SearchScreen());
  }

  void onUserTap(Conversation? conversation) {
    userData?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(S.current.userBlock)
        : Get.to(() => const ChatScreen(), arguments: conversation);
  }

  void getChatUsers() {
    isLoading = true;
    PrefService.getUserData().then((value) {
      subscription = db
          .collection(FirebaseRes.userChatList)
          .doc(value?.identity)
          .collection(FirebaseRes.userList)
          .orderBy(FirebaseRes.time, descending: true)
          .withConverter(
              fromFirestore: Conversation.fromFirestore,
              toFirestore: (Conversation value, options) => value.toFirestore())
          .snapshots()
          .listen((element) {
        userList = [];
        for (int i = 0; i < element.docs.length; i++) {
          if (element.docs[i].data().isDeleted == false) {
            userList.add(element.docs[i].data());
            notifyListeners();
          }
        }
        isLoading = false;
        notifyListeners();
      });
    });
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void onLongPress(Conversation? conversation) {
    HapticFeedback.vibrate();
    Get.dialog(
      ConfirmationDialog(
        aspectRatio: 1 / 0.6,
        clickText1: S.current.deleteChat,
        clickText2: S.current.cancel,
        heading: S.current.deleteThisChat,
        subDescription: S.current.messageWillOnlyBeRemoved,
        onNoBtnClick: () {
          Get.back();
        },
        onYesBtnClick: () {
          db
              .collection(FirebaseRes.userChatList)
              .doc(userData?.identity)
              .collection(FirebaseRes.userList)
              .doc(conversation?.user?.userIdentity)
              .update({
            FirebaseRes.isDeleted: true,
            FirebaseRes.deletedId: '${DateTime.now().millisecondsSinceEpoch}',
            FirebaseRes.block: false,
            FirebaseRes.blockFromOther: false,
          }).then((value) {
            Get.back();
          });
        },
        horizontalPadding: 65,
      ),
    );
    notifyListeners();
  }
}
