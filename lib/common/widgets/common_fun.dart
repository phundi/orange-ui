import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/model/social/feed.dart';
import 'package:orange_ui/model/user/registration_user.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/firebase_res.dart';

class CommonFun {
  static Future<void> interstitialAd(Function(InterstitialAd ad) onAdLoaded) async {
    InterstitialAd.load(
      adUnitId: Platform.isIOS
          ? "${PrefService.settingData?.appdata?.admobIntIos}"
          : "${PrefService.settingData?.appdata?.admobInt}",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  static void bannerAd(Function(Ad ad) ad) {
    BannerAd(
      adUnitId: Platform.isIOS
          ? "${PrefService.settingData?.appdata?.admobBannerIos}"
          : "${PrefService.settingData?.appdata?.admobBanner}",
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: ad,
        onAdFailedToLoad: (ad, err) {
          // print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    // if (diff.inDays > 365) {
    //   return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"}";
    // }
    // if (diff.inDays > 30) {
    //   return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"}";
    // }
    if (diff.inDays > 7) {
      return DateFormat('dd/MM/yyyy').format(d);
    }
    if (diff.inDays > 0) {
      if (diff.inDays == 1) {
        return "Yesterday";
      }
      return "${diff.inDays} days";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  static String readTimestamp(double timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp.toInt() * 1000);
    var time = '';
    if (now.day == date.day) {
      time = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    if (now.weekday > date.weekday) {
      time = DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    if (now.month == date.month) {
      time = DateFormat('dd/MMM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    return time;
  }

  static String getConversationID({required int? myId, required int? otherUserId}) {
    String conversationID = '${myId}_$otherUserId';
    List<String> v = conversationID.split('_');
    v.sort((a, b) {
      return int.parse(a).compareTo(int.parse(b));
    });
    conversationID = v.join('_');
    return conversationID;
  }

  static getLastMsg({required String msgType, required String msg}) {
    return msgType == FirebaseRes.image
        ? FirebaseRes.imageText
        : msgType == FirebaseRes.video
            ? FirebaseRes.videoText
            : msg;
  }

  static String getProfileImage({List<Images>? images}) {
    String profileImage = '';
    List<Images> tempList = images ?? [];
    if (tempList.isNotEmpty) {
      profileImage = tempList.first.image ?? '';
      return '${ConstRes.aImageBaseUrl}$profileImage';
    }
    return '';
  }

  static bool isContentAvailable({List<Content>? content}) {
    if (content != null || content!.isNotEmpty) {
      return true;
    }
    return false;
  }
}
