import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/chat_screen/widgets/premium_pop_up.dart';
import 'package:orange_ui/screen/create_call_screen/create_call_screen.dart';
import 'package:orange_ui/screen/premium_screen/premium_screen.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class ChatScreenViewModel extends BaseViewModel {
  void init() {
    getValueFromPrefs();
  }

  TextEditingController controller = TextEditingController();

  Map<String, dynamic> user = {
    'name': 'Natalia Nora',
    'age': 24,
    'address': 'Las Vegas, USA',
    'avatar': AssetRes.profile6,
  };

  List<Map<String, dynamic>> chatData = [
    {
      'sender': "Natalia",
      'msg': AppRes.user1Chat1,
      'time': "11.42 am",
      'type': "text",
    },
    {
      'sender': "Natalia",
      'msg': AppRes.user1Chat2,
      'time': "11.42 am",
      'type': "text",
    },
    {
      'sender': "You",
      'msg': AppRes.user2Chat1,
      'time': "11.50 am",
      'type': "text",
    },
    {
      'sender': "Natalia",
      'msg': AppRes.user1Chat3,
      'time': "1:05 pm",
      'type': "text",
    },
    {
      'msg': AppRes.today,
      'type': "alert",
    },
    {
      'sender': "You",
      'msg': AppRes.user2Chat2,
      'time': "10:00 am",
      'type': "text",
    },
  ];

  Future<void> getValueFromPrefs() async {
    List<String>? imageList = await PrefService.getProfileImageList();

    chatData.add({
      'sender': "Natalia",
      'msg': imageList!.first,
      'time': "11.00 am",
      'type': "image",
    });
    notifyListeners();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onVideoCallingTap() {
    Get.to(() => const CreateCallScreen());
    /*Get.dialog(
      PremiumPopUp(
        onCancelTap: onCancelTap,
        onGoPremiumTap: onGoPremiumTap,
      ),
      barrierColor: ColorRes.black3.withOpacity(0.44),
    );*/
  }

  void onMoreBtnTap() {}

  void onImageTap(Map<String, dynamic> imageData) {
    Get.dialog(
      PremiumPopUp(
        onCancelTap: onCancelTap,
        onGoPremiumTap: onGoPremiumTap,
      ),
      barrierColor: ColorRes.black3.withOpacity(0.44),
    );
  }

  void onShareBtnTap() {
    if (controller.text.trim() != '') {
      chatData.add({
        'sender': "You",
        'msg': controller.text,
        'time': dateFormat(DateTime.now()),
        'type': "text",
      });
      controller.clear();
      notifyListeners();
    }
  }

  String dateFormat(DateTime time) {
    String hour = time.hour.toString();
    String minute = time.minute.toString().padLeft(2, '0');
    bool isAm = (time.hour * 60) > 719 ? false : true;
    String timeStr = '$hour:$minute ${isAm ? 'am' : 'pm'}';

    return timeStr;
  }

  Future<void> onAddBtnTap() async {
    Get.dialog(
      PremiumPopUp(
        onCancelTap: onCancelTap,
        onGoPremiumTap: onGoPremiumTap,
      ),
      barrierColor: ColorRes.black3.withOpacity(0.44),
    );
  }

  Future<void> onCameraTap() async {
    Get.dialog(
      PremiumPopUp(
        onCancelTap: onCancelTap,
        onGoPremiumTap: onGoPremiumTap,
      ),
      barrierColor: ColorRes.black3.withOpacity(0.44),
    );
  }

  void onGoPremiumTap() {
    Get.back();
    Get.off(() => const PremiumScreen());
  }

  void onCancelTap() {
    Get.back();
  }
}
