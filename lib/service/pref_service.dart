import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orange_ui/model/chat_and_live_stream/chat.dart';
import 'package:orange_ui/model/setting.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/utils/firebase_res.dart';
import 'package:orange_ui/utils/pref_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static int userId = -1;
  static String currency = '';
  static String coinRate = '';
  static int minThreshold = 0;
  static int reverseSwipePrice = 0;
  static int liveWatchingPrice = 0;
  static int messagePrice = 0;
  static int minimumUserLive = 0;
  static int maximumMinutes = 0;
  static String iosBannerAd = "";
  static String androidBannerAd = "";
  static String iosInterstitialAd = "";
  static String androidInterstitialAd = "";
  static int isDating = 0;
  static SettingData? settingData;

  static Future<bool?> getLoginText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConst.isLogin);
  }

  static Future<void> setLoginText(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefConst.isLogin, value);
  }

  static Future<bool?> getDialog(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setDialog(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.fullName);
  }

  static Future<void> setFullName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.fullName, value);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.email);
  }

  static Future<void> setLatitude(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.latitude, value);
  }

  static Future<String?> getLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.latitude);
  }

  static Future<void> setLongitude(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.longitude, value);
  }

  static Future<String?> getLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConst.longitude);
  }

  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> saveUser(RegistrationUserData? value) async {
    if (value != null) {
      await saveString(PrefConst.registrationUser, jsonEncode(value));
    }
  }

  static void updateFirebase() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    RegistrationUserData? registrationUserData = await getUserData();
    db
        .collection(FirebaseRes.userChatList)
        .doc(registrationUserData?.identity)
        .collection(FirebaseRes.userList)
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then((value) {
      for (var element in value.docs) {
        db
            .collection(FirebaseRes.userChatList)
            .doc(element.data().user?.userIdentity)
            .collection(FirebaseRes.userList)
            .doc(registrationUserData?.identity)
            .withConverter(
              fromFirestore: Conversation.fromFirestore,
              toFirestore: (Conversation value, options) {
                return value.toFirestore();
              },
            )
            .get()
            .then((value) {
          ChatUser? user = value.data()?.user;
          user?.username = registrationUserData?.fullname ?? '';
          user?.age = registrationUserData?.age != null
              ? registrationUserData?.age.toString()
              : '';
          user?.image = registrationUserData?.images?[0].image ?? '';
          user?.city = registrationUserData?.live ?? '';
          db
              .collection(FirebaseRes.userChatList)
              .doc(element.data().user?.userIdentity)
              .collection(FirebaseRes.userList)
              .doc(registrationUserData?.identity)
              .update({FirebaseRes.user: user?.toJson()});
        });
      }
    });
  }

  static Future<void> saveSettingData(SettingData? value) async {
    await saveString(PrefConst.settingData, jsonEncode(value));
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<RegistrationUserData?> getUserData() async {
    String? data = await getString(PrefConst.registrationUser);
    if (data == null || data.isEmpty) return null;
    return RegistrationUserData.fromJson(jsonDecode(data));
  }

  static Future<SettingData?> getSettingData() async {
    String? data = await getString(PrefConst.settingData);
    if (data == null || data.isEmpty) return null;
    return SettingData.fromJson(jsonDecode(data));
  }
}
