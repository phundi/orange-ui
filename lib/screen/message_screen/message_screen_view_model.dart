import 'package:get/get.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen.dart';
import 'package:orange_ui/screen/notification_screen/notification_screen.dart';
import 'package:orange_ui/screen/search_screen/search_screen.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class MessageScreenViewModel extends BaseViewModel {
  void init() {}

  List<Map<String, dynamic>> userList = [
    {
      'name': "Natalia Nora",
      'age': 24,
      'msg': 'Hey, Can we meet today at Lackview..',
      'newMsg': true,
      'image': AssetRes.profile6,
      'sendByYou': false,
      'time': "5 min",
      'tickMark': true,
    },
    {
      'name': "Pinky Arora",
      'age': 22,
      'msg': 'Hey, Cutie, What are you doing?',
      'newMsg': false,
      'image': AssetRes.profile9,
      'sendByYou': true,
      'time': "Yesterday",
      'tickMark': true,
    },
    {
      'name': "Nora Malik",
      'age': 28,
      'msg': 'Where do you live man?',
      'newMsg': false,
      'image': AssetRes.profile10,
      'sendByYou': true,
      'time': "Tuesday",
      'tickMark': false,
    },
    {
      'name': "Aron Nora",
      'age': 26,
      'msg': 'Image 📷',
      'newMsg': false,
      'image': AssetRes.profile11,
      'sendByYou': false,
      'time': "8 Sep 2021",
      'tickMark': false,
    },
    {
      'name': "Norak Patel",
      'age': 26,
      'msg': 'Image 📷',
      'newMsg': false,
      'image': AssetRes.profile12,
      'sendByYou': false,
      'time': "5 Sep 2021",
      'tickMark': true,
    },
    {
      'name': "Natalia Nora",
      'age': 24,
      'msg': 'Hey, Can we meet today at Lackview..',
      'newMsg': true,
      'image': AssetRes.profile6,
      'sendByYou': false,
      'time': "5 min",
      'tickMark': true,
    },
    {
      'name': "Pinky Arora",
      'age': 22,
      'msg': 'Hey, Cutie, What are you doing?',
      'newMsg': false,
      'image': AssetRes.profile9,
      'sendByYou': true,
      'time': "Yesterday",
      'tickMark': true,
    },
    {
      'name': "Nora Malik",
      'age': 28,
      'msg': 'Where do you live man?',
      'newMsg': false,
      'image': AssetRes.profile10,
      'sendByYou': true,
      'time': "Tuesday",
      'tickMark': false,
    },
    {
      'name': "Aron Nora",
      'age': 26,
      'msg': 'Image 📷',
      'newMsg': false,
      'image': AssetRes.profile11,
      'sendByYou': false,
      'time': "8 Sep 2021",
      'tickMark': false,
    },
    {
      'name': "Norak Patel",
      'age': 26,
      'msg': 'Image 📷',
      'newMsg': false,
      'image': AssetRes.profile12,
      'sendByYou': false,
      'time': "5 Sep 2021",
      'tickMark': true,
    },
  ];

  void onNotificationTap() {
    Get.to(() => const NotificationScreen());
  }

  void onSearchTap() {
    Get.to(() => const SearchScreen());
  }

  void onUserTap() {
    Get.to(() => const ChatScreen());
  }
}
