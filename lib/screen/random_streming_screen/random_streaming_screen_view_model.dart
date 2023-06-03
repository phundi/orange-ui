import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class RandomStreamingScreenViewModel extends BaseViewModel {
  void init() {
    getValueFromPrefs();
  }

  List<Map<String, dynamic>> commentList = [
    {
      'name': "Hamza Patel - India",
      'comment': "This teacher is so so amazing, her eyes are little scary 😒",
      'image': AssetRes.profile23,
      'type': 'text',
    },
    {
      'name': "Kety Kate - South Africa",
      'comment': AssetRes.heart,
      'image': AssetRes.profile6,
      'type': 'image',
    },
    {
      'name': "Jhon Maina - USA",
      'comment': "Hello everyone ✌",
      'image': AssetRes.profile24,
      'type': 'text',
    },
    {
      'name': "Siara Andrewz - Germany",
      'comment':
          "Hey, Cuttie. See you after many days. Looking so nice dear 🔥",
      'image': AssetRes.profile25,
      'type': 'text',
    },
  ];
  String userName = '';

  TextEditingController commentController = TextEditingController();

  Future<void> getValueFromPrefs() async {
    userName = (await PrefService.getFullName() ?? '');
  }

  void onTitleTap() {}

  void onEndBtnTap() {
    Get.back();
  }

  void onCameraTap() {}

  void onSpeakerTap() {}

  void onDiamondTap() {}

  void onCommentSend() {
    if (commentController.text == '') {
      return;
    }
    commentList.add({
      'name': userName,
      'comment': commentController.text,
      'image': AssetRes.profile2,
      'type': 'text',
    });
    commentController.clear();
    notifyListeners();
  }
}
