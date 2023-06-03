import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class NotificationScreenViewModel extends BaseViewModel {
  void init() {}

  String notification = AppRes.notification;
  int tabIndex = 0;

  List<Map<String, dynamic>> notificationList = [
    {
      'image': AssetRes.userPick2,
      'name': 'Pinky Arora',
      'age': 22,
      'msg':
          'Pinkey Arora has liked your profile, You should check their profile.',
      'time': '5 min',
      'type': "personal",
    },
    {
      'image': AssetRes.profile27,
      'name': 'Sagar Patel',
      'age': 22,
      'msg':
          'Sagar Patel has liked your profile, You should check their profile.',
      'time': 'Yesterday',
      'type': "personal",
    },
    {
      'image': 'orange',
      'name': 'Coin Offers',
      'age': 0,
      'msg':
          'Subscribe to the Premium plan and enjoy unlimited features and have more fun.',
      'time': '5 Sep 2021',
      'type': "platform",
    },
    {
      'image': AssetRes.userPick2,
      'name': 'Pinky Arora',
      'age': 22,
      'msg':
          'Pinkey Arora has liked your profile, You should check their profile.',
      'time': '5 min',
      'type': "personal",
    },
    {
      'image': AssetRes.profile27,
      'name': 'Sagar Patel',
      'age': 22,
      'msg':
          'Sagar Patel has liked your profile, You should check their profile.',
      'time': 'Yesterday',
      'type': "personal",
    },
    {
      'image': 'orange',
      'name': 'Privacy Policy Update',
      'age': 0,
      'msg':
          'Subscribe to the Premium plan and enjoy unlimited features and have more fun.',
      'time': '5 Sep 2021',
      'type': "platform",
    },
    {
      'image': AssetRes.userPick2,
      'name': 'Pinky Arora',
      'age': 22,
      'msg':
          'Pinkey Arora has liked your profile, You should check their profile.',
      'time': '5 min',
      'type': "personal",
    },
    {
      'image': AssetRes.profile27,
      'name': 'Sagar Patel',
      'age': 22,
      'msg':
          'Sagar Patel has liked your profile, You should check their profile.',
      'time': 'Yesterday',
      'type': "personal",
    },
    {
      'image': 'orange',
      'name': 'Coin Offers',
      'age': 0,
      'msg':
          'Subscribe to the Premium plan and enjoy unlimited features and have more fun.',
      'time': '5 Sep 2021',
      'type': "platform",
    },
    {
      'image': AssetRes.userPick2,
      'name': 'Pinky Arora',
      'age': 22,
      'msg':
          'Pinkey Arora has liked your profile, You should check their profile.',
      'time': '5 min',
      'type': "personal",
    },
    {
      'image': AssetRes.profile27,
      'name': 'Sagar Patel',
      'age': 22,
      'msg':
          'Sagar Patel has liked your profile, You should check their profile.',
      'time': 'Yesterday',
      'type': "personal",
    },
    {
      'image': 'orange',
      'name': 'Privacy Policy Update',
      'age': 0,
      'msg':
          'Subscribe to the Premium plan and enjoy unlimited features and have more fun.',
      'time': '5 Sep 2021',
      'type': "platform",
    },
  ];

  void onBack() {
    Get.back();
  }

  void onTabChange(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
