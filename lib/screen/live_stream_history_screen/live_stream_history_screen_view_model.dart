import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LiveStreamHistoryViewModel extends BaseViewModel {
  void init() {}

  List<Map<String, dynamic>> dataList = [
    {
      'time': "10:00 am to 11:24 am",
      'date': "5 Sep 2021",
      'duration': "1 hr 24 mins",
      'diamonds': "2536",
    },
    {
      'time': "10:00 am to 11:24 am",
      'date': "6 Sep 2021",
      'duration': "1 hr 24 mins",
      'diamonds': "2536",
    },
    {
      'time': "10:00 am to 11:24 am",
      'date': "7 Sep 2021",
      'duration': "1 hr 24 mins",
      'diamonds': "2536",
    },
  ];

  void onBackBtnTap() {
    Get.back();
  }
}
